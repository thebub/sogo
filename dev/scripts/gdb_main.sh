#!/bin/bash

PROCESS_ID=`/usr/bin/pgrep -P 1 sogod`

sudo gdb -p $PROCESS_ID