#!/bin/bash
AUR_AUTO_VOTE_PASSWORD="$(/usr/bin/gpg --decrypt ~/Documentos/scripts/aur_vote.senha.gpg)"
export AUR_AUTO_VOTE_PASSWORD
/usr/bin/aur-auto-vote lucasrizzini
