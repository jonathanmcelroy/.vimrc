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
cp ~/bin/uploadConfig.sh bin/
cp ~/bin/addComments.sh bin/
cp ~/bin/downloadConfig.sh bin/

git add . --all

if ! git diff --cached --exit-code >/dev/null; then
    git commit -m 'Updated everything'
    git push
fi

