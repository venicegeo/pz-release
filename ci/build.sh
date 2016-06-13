#!/bin/bash -e

pushd `dirname $0` > /dev/null
base=$(pwd -P)
popd > /dev/null

cat /dev/null > $base/manifest.lock

[ -n "$1" ] && $base/lib/params.sh "$@"

for app in `cat $base/manifest.txt` ; do
  _app=$(echo $app | tr '-' '_')
  [ -z ${!_app} ] && sha=$($base/lib/sha.sh $app)
  [ -z $sha ] && sha=master
  echo "$app=$sha" >> $base/manifest.lock
done
