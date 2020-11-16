#!/bin/bash

PROCESS_ID=`/usr/bin/pgrep -o sogod`

gdb -p $PROCESS_ID