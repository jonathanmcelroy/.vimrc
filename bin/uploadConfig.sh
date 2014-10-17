#!/usr/bin/env bash
WORKTREE=$HOME/configuration/

mkdir -p $WORKTREE

cd $WORKTREE
if ! [ -d .git ]; then
    git clone https://github.com/jonathanmcelroy/configuration.git $WORKTREE
fi

cp ~/.vimrc .
cp ~/.zshrc .
cp ~/.cppuseful/ .
cp ~/.cuseful/ .

mkdir -p bin
find $HOME/bin -perm /a+x -type f -exec cp {} ./bin/ \;

git add .
DELFILES=$(git ls-files --deleted -z)
if [ ! -z "$DELFILES" ]; then
    git rm "$DELFILES"
fi

if ! git diff --cached --quiet; then
    git commit -m 'Updated configuration'
fi

if git diff --stat origin/master --quiet; then
    git push
fi

