#!/bin/bash
# This is the script to update some tools install by git clone
# Author: yushiuan9499 date: 2025-03-23
TARGET_DIR=("$HOME/.oh-my-zsh" "$HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions" "$HOME/.oh-my-zsh/custom/plugins/zsh-completions" "$HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting")

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
  echo "fetching $dir"
  git fetch origin master >/dev/null 2>&1   # > /dev/null 2>&1 is used to suppress output
  LOCAL=$(git rev-parse HEAD)               # Get the local commit hash
  REMOTE=$(git rev-parse origin/master)     # Get the remote commit hash
  BASE=$(git merge-base HEAD origin/master) # Get the common ancestor commit hash
  if [ "$LOCAL" = "$REMOTE" ]; then
    echo "Directory $dir is up-to-date."
  elif [ "$LOCAL" = "$BASE" ]; then
    echo "Directory $dir needs to pull."
    read -p "Do you want to pull? [y/n] " answer
    answer=${answer:-y} # Default answer is y
    if [ "$answer" != "y" ]; then
      echo "Aborted."
      exit 1
    fi
    git pull origin master
  else
    echo "Directory $dir has diverged."
  fi
done
