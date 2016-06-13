#!/bin/bash -e

[ -z "$1" ] && { echo "usage: $(basename $0) <sprint-number>" 2>&1; exit 1; }

sprint=$1
date=$(date '+%d-%m-%Y %H:%M')
number=$(git rev-list --count HEAD)
git tag -am "Date: $date, Sprint: $sprint" v${number}
