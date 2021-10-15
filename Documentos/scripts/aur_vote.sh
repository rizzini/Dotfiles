#!/bin/bash
/usr/bin/gpg --decrypt-files  /home/lucas/Documentos/scripts/aur_vote.senha.gpg
export AUR_AUTO_VOTE_PASSWORD="$(cat /home/lucas/Documentos/scripts/aur_vote.senha)"
rm /home/lucas/Documentos/scripts/aur_vote.senha
aur-auto-vote lucasrizzini &&




