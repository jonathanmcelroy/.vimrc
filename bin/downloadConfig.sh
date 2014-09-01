#!/usr/bin/env bash
WORKTREE=$HOME/configuration/

mkdir -p $WORKTREE

cd $WORKTREE
if ! [ -d .git ]; then
    git clone https://github.com/jonathanmcelroy/configuration.git $WORKTREE
else
    git pull
fi

if ! [ -d $HOME/.vim/bundle/Vundle.vim ]; then
    git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

cp .vimrc ~/.vimrc
cp .cppuseful/ ~/.cppuseful -rf
cp .cuseful/ ~/.cuseful -rf
cp uploadConfig.sh ~/bin/uploadConfig.sh
cp addComments.sh ~/bin/addComments.sh
cp downloadConfig.sh ~/bin/downloadConfig.sh
