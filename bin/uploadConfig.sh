#!/usr/bin/env bash
WORKTREE=$HOME/configuration/

echo "Creating configuration directory"
mkdir -p $WORKTREE

echo "Cloning configuration git project if it doesn't exist"
cd $WORKTREE
if ! [ -d .git ]; then
    git clone https://github.com/jonathanmcelroy/configuration.git $WORKTREE
fi

echo "Copying over files"
cp ~/.vimrc .
cp ~/.zshrc .
cp ~/.cppuseful/ . -r
cp ~/.cuseful/ . -r

echo "Copying over binary files"
mkdir -p bin
find $HOME/.local/bin -perm /a+x -type f -exec cp {} ./bin/ \;

echo "Delting files from git"
git add .
DELFILES=$(git ls-files --deleted -z)
if [ ! -z "$DELFILES" ]; then
    git rm "$DELFILES"
fi

echo "Commiting git"
if ! git diff --cached --quiet; then
    git commit -m 'Updated configuration'
fi

echo "Pusning git"
if ! git diff --stat origin/master --quiet; then
    git push
fi

