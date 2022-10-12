#!/bin/sh

/sbin/smartd;
cat /var/log/syslog.log | tail -n 20;
# smartd: [error] Unable to lock PID file: smartd is already running

/etc/init.d/smartd stop;

/etc/init.d/smartd status;

/sbin/smartd --help;
# smartd <options>
#    -i   Polling interval (in minutes) for smartd
#         (default Polling interval is 30 minutes)


# /sbin/smartd -i 5; # THIS IS WHAT IS DESIRED TO RUN AS THE SERVICE

cat /etc/init.d/smartd;

cat /etc/vmware/smart_plugin.conf;

find / -iname *smart*;

cat /var/run/vmware/smartd.PID
# /etc/init.d/smartd
# /var/run/vmware/smartd.PID
# /bin/smartd
# ...


# Find the process which is holding up smartd from working as intended
cat /var/run/vmware/smartd.PID


ps | grep $(cat /var/run/vmware/smartd.PID;);
# No processes found --> PID file is a dangling pointer --> remove it

rm -fv /var/run/vmware/smartd.PID;

/etc/init.d/smartd status;

/etc/init.d/smartd start;

# ------------------------------

vi "/etc/rc.local.d/local.sh";

# Add the following into "local.sh":

# Poll the SMART daemon every 15 minutes (instead of the default of every 30)
SMARTD_POLL_INTERVAL=15
/etc/init.d/smartd stop;
sed -r "s/^(.+ -t \"\\\$\{MAX_RETRIES\}\" )(\"\\\$\{SMARTD\}\".+$)/\1-i ${SMARTD_POLL_INTERVAL:-15} \2/g" -i "/etc/init.d/smartd";
/etc/init.d/smartd start;


# ------------------------------

# Pre-Check - Get the config & service status before running the update
cat /etc/init.d/smartd;
ps -c | grep smartd | grep -v grep;

# Run the update
/etc/rc.local.d/local.sh

# Post-Check - Verify the configuration was applied as-intended
cat /etc/init.d/smartd;
ps -c | grep smartd | grep -v grep;



# ------------------------------
# Finally, get smart disk info at a reasonable pace

esxcli storage core device list \
| grep -i 'Other UIDs:' \
| awk '{print $3}' \
| while read EACH_DEVICE_ID; do
echo "------------------------------";
echo "EACH_DEVICE_ID:  ${EACH_DEVICE_ID}";
esxcli storage core device smart get -d "${EACH_DEVICE_ID}";
done;


# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "ESXi S.M.A.R.T. health monitoring for hard drives (2040405)"  |  https://kb.vmware.com/s/article/2040405
#
#   williamlam.com  |  "Quick Tip - smartd configurable polling interval in vSphere 6.0"  |  https://williamlam.com/2015/02/quick-tip-smartd-configurable-polling-interval-in-vsphere-6-0.html
#
# ------------------------------------------------------------