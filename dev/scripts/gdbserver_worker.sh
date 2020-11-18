#!/bin/bash

PARENT_PROCESS_ID=`/usr/bin/pgrep -P 1 sogod`
PROCESS_ID=`/usr/bin/pgrep -P $PARENT_PROCESS_ID sogod`

gdbserver --attach 127.0.0.1:1337 $PROCESS_ID