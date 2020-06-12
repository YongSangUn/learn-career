#!/bin/bash

cd ${BASH_SOURCE%/*} 2>/dev/null
./stop.sh $@ >/dev/null 2>&1 && ./start.sh $@ >/dev/null 2>&1
