#!/usr/bin/env bash
WORKTREE=$HOME/configuration/

mkdir -p $WORKTREE

cd $WORKTREE
if ! [ -d .git ]; then
    git clone https://github.com/jonathanmcelroy/configuration.git $WORKTREE
else
    git pull
fi

mkdir -p "$HOME/.vim/autoload"
if ! [ -f "$HOME/.vim/autoload/plug.vim" ] ;then
    curl -fLo "$HOME/.vim/autoload/plug.vim" "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
fi

cp .vimrc "$HOME/.vimrc"
cp .zshrc "$HOME/.zshrc"
cp notes.txt "$HOME/notes.txt"
cp .cppuseful/ "$HOME" -rf
cp .cuseful/ "$HOME" -rf

mkdir -p $HOME/bin
find ./bin -perm /a+x -type f -exec cp {} $HOME/bin/ \;
