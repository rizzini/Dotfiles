#!/bin/bash
/usr/bin/sleep 2 &&
export DISPLAY=:0
/usr/bin/nvidia-settings --load-config-only
