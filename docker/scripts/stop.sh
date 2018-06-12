#!/bin/bash -ex

current_dir=`dirname $0`
cd $current_dir

./stop-crailsapp.sh
./stop-sidekic.sh
./stop-faye.sh
