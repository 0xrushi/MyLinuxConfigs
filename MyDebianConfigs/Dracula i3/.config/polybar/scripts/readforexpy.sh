#!/bin/sh 
exec 2>/dev/null
commandOutput="$(python3 -W ignore /home/h4x3d/.config/polybar/scripts/forex.py)"
echo -n $commandOutput