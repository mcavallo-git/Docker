#!/bin/sh
# ------------------------------------------------------ #

# Linux - Basic Base64 String Encoding/Decoding

# ------------------------------------------------------ #

### ENCODE
plaintext="Some string to encode to base64"; \
encoded_b64=$(echo -n ${plaintext} | base64 --wrap=0); \
echo $encoded_b64;

# ------------------------------------------------------ #

### DECODE
encoded_b64="U29tZSBzdHJpbmcgdG8gZW5jb2Rl"
decoded_b64=$(echo -n ${encoded_b64} | base64 --decode); \
echo $decoded_b64;

# ------------------------------------------------------ #
