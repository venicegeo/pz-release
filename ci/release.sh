#!/bin/bash -x

pushd `dirname $0` > /dev/null
root=$(pwd -P)/..
popd > /dev/null

source $root/ci/vars.sh

if [[ -n "$component_revision" && -n "$component" ]]; then
  git="git --exec-path $root/src/$component_revision"

  $git checkout master
  $git pull origin master
  $git reset --hard $component_revision
fi

outfile=$root/public/$APP.$EXT
[ -z "$tag" ] && version=$(git describe --long --tags --always) || version=$tag

branch=$(git symbolic-ref HEAD)
branch=${branch##refs/heads/}
echo $branch | grep -q rc && rc="-rc"

out="{\"version\": \"${version}${rc}\",\"components\":{"

sep=
for app in `cat $root/config/repos.txt` ; do
  git="git --exec-path $root/src/$app"
  version=$($git describe --long --tags --always)
  out="${out}${sep}\"$app\":\"$version\""
  sep=","
done

out="${out}}}"

echo $out > $outfile

git --exec-path $root add \*
git --exec-path $root commit -m "Automated Release - $date [$tag]"
[ -n "$tag" ] && git tag -am "Version ${tag}${rc}" ${tag}${rc}
git --exec-path $root push origin $branch
git --exec-path $root push origin $branch --tags
