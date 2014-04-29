#!/bin/bash
###########################
# Filename      : addHeading.sh
# Author        : Jonathan McElroy
# Description   : Adds the correct file heading comments to various kinds of
#                 files
# Date Modified:
#   2/16/14 -
#       File created
#
#   2/19/14 -
#       Added ability to comment all files in the current directory
###########################

# either comment the given files or all the files in the current directory
files=$@
if [ -z $files ]; then
    files=*
fi

author="Jonathan McElroy"
description="TODO: Finish Description"
dateModified="$(date +%m/%d/%Y)"

for file in $files
do
    # if the file exists
    if [ -e "$file" ]; then
        echo $file
        # get the extension
        ext=${file##*\.}
        echo $ext

        # header comments
        case "$ext" in
            c) # c style comments
                source ~/.comments/c.sh
                ;;
            cpp) # cpp style comments
                source ~/.comments/cpp.sh
                ;;
            py|sh) # python style comments
                source ~/.comments/py.sh
                ;;
        esac

        # shabang line
        #case "$est" in
            #py)
                #beginCom="#!/usr/bin/env python\n$beginCom"
                #;;
            #sh)
                #beginCom="#!/bin/sh\n$beginCom"
                #;;

        if [[ ! "`head $file`" == "$beginHeader"* ]]; then
            comment="$beginHeader
$inCom Filename:      $file
$inCom Author:        $author
$inCom Description:   $description

$inCom Date Modified: $dateModified
$inCom   - Created
$endHeader
"

            echo Adding comment to $file
            echo "$comment""$(cat $file)" > $file
        fi
    fi
done
