#!/bin/bash
TARGET_DIR=("$HOME/.config")

for dir in $TARGET_DIR; do
    if [ ! -d $dir ]; then
        echo "Directory $dir does not exist."
        exit 1
    fi
    cd $dir || exit 1
    if [ ! -d .git ]; then
        echo "Directory $dir is not a git repository."
        exit 1
    fi
    if [ -n "$(git status --porcelain)" ]; then
        echo "Directory $dir is not clean."
        git add .
        git commit -m "Auto $(date +%F-%H%M)"
        git push origin master
    fi
done
