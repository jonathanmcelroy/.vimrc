#!/usr/bin/env bash
WORKTREE=$HOME/.configuration.git/

mkdir -p $WORKTREE

cd $WORKTREE
if ! git status; then
    git clone https://github.com/jonathanmcelroy/.vimrc.git $WORKTREE
else
    git pull
fi

cp .vimrc ~/.vimrc
cp .cppuseful/ ~/.cppuseful/ -r
cp uploadConfig.sh ~/bin/uploadConfig.sh
cp addComments.sh ~/bin/addComments.sh
cp downloadConfig.sh ~/bin/downloadConfig.sh
