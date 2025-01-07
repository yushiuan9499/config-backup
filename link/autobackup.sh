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
        read -p "Do you want to commit? [y/n] " answer
        answer=${answer:-y} # Default answer is y
        if [ "$answer" != "y" ]; then
            echo "Aborted."
            exit 1
        fi
        git add .
        read -p "Enter commit message: " message
        message=${message:-Auto $(date +%F-%H:%M)} # Default message is Auto date-time
        git commit -m "$message"
        read -p "Do you want to push? [y/n] " answer
        answer=${answer:-y} # Default answer is you
        if [ "$answer" != "y" ]; then
            echo "Aborted."
            exit 1
        fi
        git push origin master
    fi
done
