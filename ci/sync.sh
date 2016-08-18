#!/bin/bash

pushd `dirname $0` > /dev/null
base=$(pwd -P)
popd > /dev/null

for app in `cat $base/../apps.txt` ; do
  _app=$(echo $app | tr '-' '_')

  [ -z ${!_app} ] && sha=$(cf apps | grep $app | awk '{print $1}' | awk -F '-' '{print $NF}') && sha=${sha: -7}
  [ -z $sha ] && { echo "$app UNKNOWN SHA"; exit 1; }

  [ pz-svcs-prevgen = $app ] && app=pzsvc-preview-generator

  git="git -C $base/../src/$app"

  $git checkout master
  $git pull origin master
  $git reset --hard $sha
done
