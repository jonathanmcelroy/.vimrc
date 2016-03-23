#!/usr/bin/env bash
WORKTREE=$HOME/configuration/

echo "Creating configuration directory"
mkdir -p $WORKTREE

echo "Cloning or pulling configuration git project"
cd $WORKTREE
if ! [ -d .git ]; then
    git clone https://github.com/jonathanmcelroy/configuration.git $WORKTREE
else
    git pull
fi

echo "Bootstrapping vim plugin: 'plug'"
if ! [ -d "$HOME/.vim/autoload" ] ;then
    mkdir -p "$HOME/.vim/autoload"
    curl -fLo "$HOME/.vim/autoload/plug.vim" https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

#if ! [ -d $HOME/.vim/bundle/vundle ]; then
    #git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/vundle
#fi

echo "Copying over files"
cp .vimrc "$HOME/.vimrc"
cp .zshrc "$HOME/.zshrc"
cp notes.txt "$HOME/notes.txt"
cp .cppuseful/ "$HOME" -rf
cp .cuseful/ "$HOME" -rf

echo "Copying over binary files"
mkdir -p $HOME/bin
find ./bin -perm /a+x -type f -exec cp {} $HOME/bin/ \;
