#!/bin/bash -ex

current_dir=`dirname $0`
cd $current_dir

./launch-crailsapp.sh
./launch-sidekic.sh
./launch-faye.sh
