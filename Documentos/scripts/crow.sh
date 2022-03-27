#!/bin/bash
if [ -z $(pgrep hl2_linux) ];then
    dbus-send --type=method_call --dest=io.crow_translate.CrowTranslate /io/crow_translate/CrowTranslate/MainWindow io.crow_translate.CrowTranslate.MainWindow.open
fi
