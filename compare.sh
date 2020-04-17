#!/bin/sh
# Compares baserom.gbc and MONSGD.gbc

# create baserom.txt if necessary
if [ ! -f baserom.txt ]; then
    hexdump -C baserom.gbc > baserom.txt
fi

hexdump -C MONSGD.gbc > MONSGD.txt

diff -u baserom.txt MONSGD.txt
