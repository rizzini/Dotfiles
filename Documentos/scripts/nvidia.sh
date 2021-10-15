#!/bin/bash
sleep 10 &&
export DISPLAY=:0
nvidia-settings --load-config-only
