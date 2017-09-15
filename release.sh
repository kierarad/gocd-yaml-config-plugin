#!/bin/bash

if [ -z "$GITHUB_TOKEN" ]; then
    echo "GITHUB_TOKEN is unset";
    exit 1;
fi


if [ ! -f linux-amd64-github-release.tar.bz2 ]; then
    wget https://github.com/aktau/github-release/releases/download/v0.6.2/linux-amd64-github-release.tar.bz2 -O linux-amd64-github-release.tar.bz2
fi
tar xf linux-amd64-github-release.tar.bz2

VERSION=$(ls build/libs/yaml-config-plugin-*.jar | grep -Eo '[0-9]+\.[0-9]+\.[0-9]+')
GHRELEASE_BIN="./bin/linux/amd64/github-release"

$GHRELEASE_BIN release \
  --user tomzo \
  --repo gocd-yaml-config-plugin \
  --tag $VERSION \
  --name $VERSION \
  --pre-release

$GHRELEASE_BIN upload \
  --user tomzo \
  --repo gocd-yaml-config-plugin \
  --tag $VERSION \
  --name "yaml-config-plugin-$VERSION.jar" \
  --file build/libs/yaml-config-plugin-$VERSION.jar
