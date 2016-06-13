#!/bin/bash -e

pushd `dirname $0` > /dev/null
base=$(pwd -P)
popd > /dev/null

[ -z "$target_domain" ] && target_domain="stage.geointservices.io"

curl -O ${CI_URL}/jnlpJars/jenkins-cli.jar

params="-p domain=$target_domain"
for line in `cat $base/manifest.lock` ; do
  _app=$(echo $line | awk -F '=' '{print $1}')
  sha=$(echo $line | awk -F '=' '{print $2}')

  params="$params -p ${_app}_revision=$sha"
done

set +x
export HISTFILE=/dev/null
java -jar jenkins-cli.jar \
  -s $CI_URL build piazza/delivery/deploy \
  --username $CI_USER \
  --password $CI_PASSWORD \
  $params
