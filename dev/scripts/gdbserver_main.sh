#!/bin/bash

PROCESS_ID=`/usr/bin/pgrep -P 1 sogod`

gdbserver --attach 127.0.0.1:1337 $PROCESS_ID

