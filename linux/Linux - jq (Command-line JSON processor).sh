#!/bin/bash
# ------------------------------------------------------------
# Install jq
#

# DEBIAN - Install jq
apt-get update -y; apt-get install -y "jq";

# RHEL - Install jq
curl -o "/usr/bin/jq" "https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64" && chmod 0755 "/usr/bin/jq";


# ------------------------------------------------------------
# jq - Convert a bash associative array to a JSON object
#
unset DAT_ARRAY; declare -a DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY+=("Val-1");
DAT_ARRAY+=("Val-2");
DAT_ARRAY+=("Val-3");
DAT_ARRAY+=("Val-4");
for i in "${!DAT_ARRAY[@]}"; do echo "$i"; echo "${DAT_ARRAY[$i]}"; done | jq -n -R 'reduce inputs as $i ({}; . + { ($i): (input|(tonumber? // .)) })';


# ------------------------------------------------------------
# jq - Convert a bash NON-associative array a JSON object
#

unset DAT_ARRAY; declare -a DAT_ARRAY; # [Re-]Instantiate bash array
DAT_ARRAY=();
DAT_ARRAY+=("Item-One");
DAT_ARRAY+=("Item-One");
DAT_ARRAY+=("Item-Two");
DAT_ARRAY+=("Item-A");
DAT_ARRAY+=("Item-A");
DAT_ARRAY+=("Item-B");
printf '%s\n' "${DAT_ARRAY[@]}" | jq -R . | jq -s .;


# ------------------------------------------------------------
# jq - Get the first 2 items in the "items" property's array (which is within/just-under the main JSON object)
#
curl "https://ip-ranges.atlassian.com" | jq '.items[0:2]';


# ------------------------------------------------------------
# jq - Grab JSON from the given URL
#   |--> Parse the "items" property from the top-level JSON object
#   |---> Parse all nested "cidr" properties within said "item" property
#
curl "https://ip-ranges.atlassian.com" | jq '.items[] | .cidr';


# ------------------------------------------------------------
# jq - Grab JSON from the given URL
#   |--> Parse the "items" property from the top-level JSON object
#   |---> Parse all nested "cidr" properties within said "item" property
#   |----> Slice off all double-quotes (prepping for output)
#
curl "https://ip-ranges.atlassian.com" | jq '.items[] | .cidr' | tr -d '"';


# ------------------------------------------------------------
# jq - Grab JSON from the given URL
#   |--> Parse the "items" property from the top-level JSON object
#   |---> Parse all nested "cidr" properties within said "item" property
#   |----> Slice off all double-quotes (prepping for output)
#   |-----> Wrap the jq call in a for-loop and add some string to the beginning/end of each line to prep it to-be-used-by as an NGINX IPv4 whitelist
#
for EACH_CIDR in $(curl -s "https://ip-ranges.atlassian.com" | jq '.items[] | .cidr' | tr -d '"' | sort); do echo "allow ${EACH_CIDR};"; done;


# ------------------------------------------------------------
# Replace JSON Dynamically
#
cat "/etc/docker/daemon.json" | jq;
jq --arg SETPROP "local" '."log-driver" = $SETPROP' "/etc/docker/daemon.json" > "/etc/docker/daemon.updated.json"; mv -f "/etc/docker/daemon.updated.json" "/etc/docker/daemon.json";
jq --arg SETPROP "25m" '."log-opts"."max-size" = $SETPROP' "/etc/docker/daemon.json" > "/etc/docker/daemon.updated.json"; mv -f "/etc/docker/daemon.updated.json" "/etc/docker/daemon.json";
jq --arg SETPROP "1" '."log-opts"."max-file" = $SETPROP' "/etc/docker/daemon.json" > "/etc/docker/daemon.updated.json"; mv -f "/etc/docker/daemon.updated.json" "/etc/docker/daemon.json";
jq --arg SETPROP "false" '."log-opts"."compress" = $SETPROP' "/etc/docker/daemon.json" > "/etc/docker/daemon.updated.json"; mv -f "/etc/docker/daemon.updated.json" "/etc/docker/daemon.json";
cat "/etc/docker/daemon.json" | jq;


# ------------------------------------------------------------
# Citation(s)
#
#   github.com  |  "Releases · stedolan/jq · GitHub"  |  https://github.com/stedolan/jq/releases
#
#   github.com  |  "GitHub - stedolan/jq: Command-line JSON processor"  |  https://github.com/stedolan/jq/
#
#   github.io  |  "[jq] Tutorial"  |  https://stedolan.github.io/jq/tutorial/
#
#   serverfault.com  |  "How to install jq on RHEL6.5 - Server Fault"  |  https://serverfault.com/a/768061
#
#   stackoverflow.com  |  "bash - Add new element to existing JSON array with jq - Stack Overflow"  |  https://stackoverflow.com/a/42248841
#
#   stackoverflow.com  |  "bash - Modify a key-value in a json using jq - Stack Overflow"  |  https://stackoverflow.com/a/42717073
#
#   stackoverflow.com  |  "Constructing a json hash from a bash associative array - Stack Overflow"  |  https://stackoverflow.com/a/44792751
#
#   stackoverflow.com  |  "How to format a bash array as a JSON array"  |  https://stackoverflow.com/a/26809318
#
# ------------------------------------------------------------