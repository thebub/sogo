#!/bin/bash

PARENT_PROCESS_ID=`/usr/bin/pgrep -P 1 sogod`
PROCESS_ID=`/usr/bin/pgrep -P $PARENT_PROCESS_ID sogod`

sudo gdb -p $PROCESS_ID