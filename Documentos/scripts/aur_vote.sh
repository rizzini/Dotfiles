#!/bin/bash
export AUR_AUTO_VOTE_PASSWORD="$(/usr/bin/gpg --decrypt ~/Documentos/scripts/aur_vote.senha.gpg)"
/usr/bin/aur-auto-vote lucasrizzini




