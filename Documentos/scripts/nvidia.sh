#!/bin/bash
sleep 4 &&
export DISPLAY=:0
nvidia-settings --load-config-only
