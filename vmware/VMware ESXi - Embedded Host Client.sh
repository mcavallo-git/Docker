#!/bin/bash
# ------------------------------------------------------------
#
# ESXi Embedded Host Client
# 
# ------------------------------------------------------------
#
# The ESXi Embedded Host Client is a native HTML and JavaScript application and is served directly from your ESXi host! It should perform much better than any of the existing solutions.
#
# In short, a VIB is a software package that gets installed on a vSphere ESXi host that contains things like drivers. They have become quite a bit more common in the last few years as the supported hardware base for vSphere has increased over time.
# 
# 
# ------------------------------------------------------------


### !!! MAKE SURE TO DOUBLE CHECK THAT YOU'VE BACKED UP THE ESXI INSTANCE'S CURRENT VIB BEFORE MAKING CHANGES/UPDATES TO IT !!! ###


# Download & install the latest HTTP & Javascript ".vib" file
esxcli software vib install -v "http://download3.vmware.com/software/vmw-tools/esxui/esxui-signed-latest.vib"


# ------------------------------------------------------------
# Citation(s)
# 
#   flings.vmware.com  |  "ESXi Embedded Host Client"  |  https://flings.vmware.com/esxi-embedded-host-client#instructions
# 
# ------------------------------------------------------------