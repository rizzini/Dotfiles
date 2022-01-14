#!/bin/bash
if [ "$(systemctl is-active anbox-container-manager.service)" == 'active' ];then
    /usr/bin/sudo /usr/bin/systemctl stop anbox.service;
    /usr/bin/sudo /usr/bin/systemctl stop anbox-container-manager.service;
else
    /usr/bin/sudo /usr/bin/systemctl restart anbox.service;
fi
