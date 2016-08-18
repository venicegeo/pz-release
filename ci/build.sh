#!/bin/bash

pushd `dirname $0` > /dev/null
base=$(pwd -P)
popd > /dev/null

source $base/vars.sh

outfile=$base/../public/$APP.$EXT
[ -z "$tag" ] && version=$(git describe --long --tags --always) || version=$tag
branch=$(git describe --contains --all HEAD)

echo $branch | grep -q rc && rc="-rc"

out="{\"version\": \"${version}${rc}\",\"components\":{"

sep=
for app in `cat $base/../repos.txt` ; do
  git="git -C $base/../src/$app"
  version=$($git describe --long --tags --always)
  out="${out}${sep}\"$app\":\"$version\""
  sep=","
done

out="${out}}}"

echo $out > $outfile
