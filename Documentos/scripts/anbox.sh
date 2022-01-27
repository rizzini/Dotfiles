#!/bin/bash
if [ "$(/usr/bin/systemctl is-active anbox.service)" == 'active' ];then
    /usr/bin/sudo /usr/bin/systemctl stop anbox.service;
else
    /usr/bin/sudo /usr/bin/systemctl restart anbox.service;
fi
