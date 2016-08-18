#!/bin/bash -e

pushd `dirname $0` > /dev/null
root=$(pwd -P)
popd > /dev/null

git add $root/*
git commit -m "Automated Release - $date [$tag]"
[ -z "$tag" ] || $base/lib/tag.sh
