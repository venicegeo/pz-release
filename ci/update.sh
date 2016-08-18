#!/bin/bash

pushd `dirname $0` > /dev/null
root=$(pwd -P)/..
popd > /dev/null

[ -z "$app" ] && { echo "app undefined"; exit 1; }
[ -z "$revision" ] && { echo "revision undefined"; exit 1; }

git="git -C $root/src/$app"

$git checkout master
$git pull origin master
$git reset --hard $revision
