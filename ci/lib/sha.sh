#!/bin/bash -e

[ -z "$1" ] && { echo "usage: $(basename $0) <app-name>" 2>&1; exit 1; }

app=$1

x=$(cf apps | grep $1 | awk '{print $1}' | awk -F '-' '{print $NF}')

echo ${x: -7}
