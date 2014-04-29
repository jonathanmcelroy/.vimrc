#!/usr/bin/env bash
WORKTREE=$HOME/.configuration.git/

mkdir -p $WORKTREE

cd $WORKTREE
if ! [ -d .git ]; then
    git clone https://github.com/jonathanmcelroy/.vimrc.git $WORKTREE
fi

cp ~/.vimrc .
cp ~/.cppuseful/ . -r
cp ~/.cuseful/ . -r
cp ~/bin/uploadConfig.sh .
cp ~/bin/addComments.sh .
cp ~/bin/downloadConfig.sh .

git add .

if ! git diff --cached --exit-code; then
    git commit -m 'Updated vimrc'
    git push
fi

