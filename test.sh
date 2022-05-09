#!/bin/bash

# NO NEED TO CHANGE THIS FILE

set -e

want=`date -u "+%d-%m-%y@%H"`

make cleanup
make build
make run
got=`curl -s localhost:8228/ | jq -r .built_at`

if [ "$got" != "$want" ]; then
    echo "\nNOT OK, got: $got, want: $want"
    exit 1
fi

make cleanup
got=`docker images broken-env:demo -q`
if [ "$got" != "" ]; then
    echo "\nNOT OK, got: $got, want: No such image"
    exit 1
fi

echo "\nOK"