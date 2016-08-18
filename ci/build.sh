#!/bin/bash -x

pushd `dirname $0` > /dev/null
root=$(pwd -P)/..
popd > /dev/null

source $root/ci/vars.sh

commit=true
[ -z "$PCF_SPACE" ] && commit=false && PCF_SPACE=stage

[ "$PCF_SPACE" != stage ] && [ "$PCF_SPACE" != prod ] && { echo "noop for $PCF_SPACE"; exit; }


[ "$PCF_SPACE" = stage ] && git checkout rc
[ "$PCF_SPACE" = prod ] && git checkout master

outfile=$root/public/$APP.$EXT
[ -z "$tag" ] && version=$(git describe --long --tags --always) || version=$tag
branch=$(git describe --contains --all HEAD)

echo $branch | grep -q rc && rc="-rc"

out="{\"version\": \"${version}${rc}\",\"components\":{"

sep=
for app in `cat $root/config/repos.txt` ; do
  git="git -C $root/src/$app"
  version=$($git describe --long --tags --always)
  out="${out}${sep}\"$app\":\"$version\""
  sep=","
done

out="${out}}}"

echo $out > $outfile

$commit || exit 0

git -C $root add \*
git -C $root commit -m "Automated Release - $date [$tag]"
[ -n "$tag" ] && git tag -am "Version $tag" ${tag}
