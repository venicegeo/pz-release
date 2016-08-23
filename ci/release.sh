#!/bin/bash -x

pushd `dirname $0` > /dev/null
root=$(pwd -P)/..
popd > /dev/null

source $root/ci/vars.sh


full_branch=$(git symbolic-ref HEAD)
[ -z $full_branch ] && full_branch=$(git describe --contains --all HEAD)
branch=${full_branch##refs/heads/}
echo $branch | grep -q remotes && branch=${full_branch##remotes/origin/}
echo $branch | grep -q rc && id="-rc"
echo $branch | grep -q ci && id="-ci"
echo $branch | grep -q test && id="-TEST"
echo $branch | grep -q master && id=""

git -C $root checkout $branch
git pull origin $branch
git submodule update --init

git config user.name VeniceCI
git config user.email ci@venicegeo.io


# Update the component
if [[ -n "$component_revision" && -n "$component" ]]; then
  git="git -C $root/src/$component"

  $git checkout master
  $git pull origin master
  $git reset --hard $component_revision
fi


# Build release manifest
[ -z "$tag" ] && version=$(git describe --long --tags --always) || version=$tag

out="{\"version\": \"${version}${id}\",\"components\":{"

sep=
for app in `cat $root/config/repos.txt` ; do
  git="git -C $root/src/$app"
  version=$($git describe --long --tags --always)
  out="${out}${sep}\"$app\":\"$version\""
  sep=","
done

out="${out}}}"
outfile=$root/public/$APP.$EXT

echo $out > $outfile


# Commit and Push
git -C $root add \*
git -C $root commit -m "Automated Release - $date [$version]"
[ -n "$tag" ] && git tag -am "Version ${tag}${id}" ${tag}${id}

attempts=0

while ! git -C $root push origin $full_branch; do
  [ $attempts = 10 ] && echo "max attempts reached" && exit 1
  git -C $root pull origin $full_branch
  attempts=$((attempts + 1))
done

git -C $root push origin $full_branch --tags
