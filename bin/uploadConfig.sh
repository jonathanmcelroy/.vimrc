#!/usr/bin/env bash
WORKTREE=$HOME/configuration/

mkdir -p $WORKTREE

cd $WORKTREE
if ! [ -d .git ]; then
    git clone https://github.com/jonathanmcelroy/configuration.git $WORKTREE
fi

cp ~/.vimrc .
cp ~/.cppuseful/ . -r
cp ~/.cuseful/ . -r

mkdir -p bin
find $HOME/bin -perm /a+x -type f -exec cp {} ./bin/ \;

git add .

if ! git diff --cached --exit-code; then
    git commit -m 'Updated configuration'
    git push
fi

