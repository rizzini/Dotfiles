#!/bin/bash
if [ "$(/usr/bin/systemctl is-active anbox.service)" == 'active' ];then
    /usr/bin/sudo /usr/bin/systemctl stop anbox.service;
    /usr/bin/sudo /usr/bin/systemctl stop anbox-container-manager.service

else
    /usr/bin/sudo /usr/bin/systemctl start anbox-container-manager.service
    /usr/bin/sudo /usr/bin/systemctl start anbox.service;

fi
