#!/bin/bash -e

pushd `dirname $0` > /dev/null
base=$(pwd -P)
popd > /dev/null

[ -z "$sprint" ] && sprint=unknown

git add $base/manifest.lock
git commit -m "Automated Release - $date - Sprint $sprint"
$base/lib/tag.sh $sprint
