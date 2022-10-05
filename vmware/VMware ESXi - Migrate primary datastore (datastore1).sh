#!/bin/sh
# ------------------------------------------------------------


esxcli system coredump file list;  # Show the current coredump file

esxcli system coredump file set --unconfigure;  # Unconfigure the core dump file (while in transitionary state)

esxcli system coredump file remove --file="/vmfs/volumes/DATASTORE_ID/vmkdump/DUMPFILE_ID.dumpfile";  # Remove the core dump file

esxcli system coredump file set --enable true --smart;  # Reconfigure the core dump file automatically (once migration is complete)


# ------------------------------------------------------------
#
# Citation(s)
#
#   kb.vmware.com  |  "Configuring ESXi coredump to file instead of partition (2077516)"  |  https://kb.vmware.com/s/article/2077516?lang=en_US
#
#   kb.vmware.com  |  "How to detach a LUN device from ESXi hosts (2004605)"  |  https://kb.vmware.com/s/article/2004605
#
# ------------------------------------------------------------