#!/bin/bash
sleep 5 &&
export DISPLAY=:0
nvidia-settings --load-config-only
