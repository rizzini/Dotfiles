#!/bin/bash
/usr/bin/gpg --decrypt-files  /home/lucas/Documentos/scripts/aur_vote.senha.gpg
export AUR_AUTO_VOTE_PASSWORD="$(/usr/bin/cat /home/lucas/Documentos/scripts/aur_vote.senha)"
/usr/bin/rm /home/lucas/Documentos/scripts/aur_vote.senha
/usr/bin/aur-auto-vote lucasrizzini




