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
#cp ~/bin/uploadConfig.sh .
#cp ~/bin/addComments.sh .
#cp ~/bin/downloadConfig.sh .

find $HOME/bin -perm /a+x -type f -exec cp {} . \;

git add .

if ! git diff --cached --exit-code; then
    git commit -m 'Updated configuration'
fi
git push

