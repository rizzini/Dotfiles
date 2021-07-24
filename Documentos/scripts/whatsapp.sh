#!/bin/bash
if [ -z "$(pgrep WhatsApp)" ]; then
    rm -rf /home/lucas/.config/whatsapp-nativefier-d40211
    cp -r /home/lucas/Documentos/scripts/whatsapp-nativefier-d40211 /home/lucas/.config/whatsapp-nativefier-d40211;
fi
/usr/bin/whatsapp-nativefier &      
