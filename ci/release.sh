#!/bin/bash -x

pushd `dirname $0` > /dev/null
root=$(pwd -P)/..
popd > /dev/null

source $root/ci/vars.sh

if [[ -n "$component_revision" && -n "$component" ]]; then
  git="cd $root/src/$component_revision && git"

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
  git="cd $root/src/$app && git $root/src/$app"
  version=$($git describe --long --tags --always)
  out="${out}${sep}\"$app\":\"$version\""
  sep=","
done

out="${out}}}"

echo $out > $outfile

cd $root
git add \*
git commit -m "Automated Release - $date [$tag]"
[ -n "$tag" ] && git tag -am "Version ${tag}${rc}" ${tag}${rc}
git push origin $branch
git push origin $branch --tags
