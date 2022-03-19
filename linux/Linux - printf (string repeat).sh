#!/bin/sh
# ------------------------------------------------------------
# Linux - printf (string repeat)
# ------------------------------------------------------------


# Repeat string  -  General syntax (hardcoded count)
CHAR="-"; printf -- "${CHAR}%.0s" {1..60};  # Repeat "-" 60 times


# Repeat string  -  General syntax (variable count)
COUNT=60; CHAR="-"; printf -- "${CHAR}%.0s" $(seq ${COUNT});  # Repeat "-" 60 times


# ------------------------------------------------------------
#
# Citation(s)
#
#   www.cyberciti.biz  |  "How to repeat a character 'n' times in Bash - nixCraft"  |  https://www.cyberciti.biz/faq/repeat-a-character-in-bash-script-under-linux-unix/
#
# ------------------------------------------------------------