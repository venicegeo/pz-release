#!/bin/bash

pushd `dirname $0` > /dev/null
base=$(pwd -P)
popd > /dev/null

source $base/vars.sh

outfile=$base/../$APP.$EXT

out="{"

sep=
for app in `cat $base/../apps.txt` ; do
  _app=$(echo $app | tr '-' '_')
  [ -z ${!_app} ] && sha=$($base/lib/sha.sh $app)
  [ -z $sha ] && sha=unknown
  out="${out}${sep}\"$app\":\"$sha\""
  sep=","
done

out="${out}}"

echo $out > $outfile
