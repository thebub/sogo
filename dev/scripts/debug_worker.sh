#!/bin/bash

PROCESS_ID=`/usr/bin/pgrep -n sogod`

gdb -p $PROCESS_ID