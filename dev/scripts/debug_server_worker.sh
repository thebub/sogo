#!/bin/bash

PROCESS_ID=`/usr/bin/pgrep -n sogod`

gdbserver --attach 127.0.0.1:1337 $PROCESS_ID