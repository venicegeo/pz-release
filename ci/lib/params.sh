#!/bin/bash -e

[ -z "$1" ] && { echo "usage: $(basename $0) <[app:sha]>" 2>&1; exit 1; }

for param in $@ ; do
  app=$(echo $param | awk -F : '{print $1}')
  sha=$(echo $param | awk -F : '{print $2}')
  _app=$(echo $app | tr '-' '_')
  [ -z $sha ] && sha=master
  export "$_app=$sha"
done
