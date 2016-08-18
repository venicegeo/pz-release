#!/bin/bash -e

pushd `dirname $0` > /dev/null
root=$(pwd -P)
popd > /dev/null

git -C $root add \*
git -C $root commit -m "Automated Release - $date [$tag]"
[ -z "$tag" ] || git tag -am "Version $tag" ${tag}
