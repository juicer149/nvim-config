#!/bin/bash

cd ~/.config/nvim || exit

if [ "$1" == "push" ]; then
    git add .
    git commit -m "${2:-update}"
    git push
elif [ "$1" == "pull" ]; then
    git pull
else
    echo "Använd: ./sync.sh push [commit-meddelande] eller ./sync.sh pull"
fi
