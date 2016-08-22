#!/bin/bash

pushd `dirname $0` > /dev/null
root=$(pwd -P)/..
popd > /dev/null

root_git="git -C $root"

for app in `cat $root/config/apps.txt` ; do
  _app=$(echo $app | tr '-' '_')

  [ -z ${!_app} ] && sha=$(cf apps | grep $app | awk '{print $1}' | awk -F '-' '{print $NF}') && sha=${sha: -7}
  [ -z $sha ] && { echo "$app UNKNOWN SHA"; exit 1; }

  [ pz-svcs-prevgen = $app ] && app=pzsvc-preview-generator

  [ ! -d $root/src/$app ] && $root_git submodule add --force https://github.com/venicegeo/$app $root/src/$app

  git="git -C $root/src/$app"

  $git checkout master
  $git pull origin master
  $git reset --hard $sha
done
