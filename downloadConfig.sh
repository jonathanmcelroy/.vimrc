#!/usr/bin/env bash
WORKTREE=$HOME/.configuration.git/

mkdir -p $WORKTREE

cd $WORKTREE
if ! [ -d .git ]; then
    git clone https://github.com/jonathanmcelroy/configuration.git $WORKTREE
else
    git pull
fi

cp .vimrc ~/.vimrc
cp .cppuseful/ ~/.cppuseful -rf
cp .cuseful/ ~/.cuseful -rf
cp uploadConfig.sh ~/bin/uploadConfig.sh
cp addComments.sh ~/bin/addComments.sh
cp downloadConfig.sh ~/bin/downloadConfig.sh
