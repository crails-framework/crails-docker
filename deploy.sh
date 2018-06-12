#!/bin/bash -ex

docker/shell -v -c package.sh

heroku config $* | grep LD_LIBRARY_PATH
if [[ $? != 0 ]] ; then
  heroku config:set LD_LIBRARY_PATH=/app/lib:/app/bin $*
  heroku config:set BUILDPACK_URL=https://github.com/Plaristote/heroku-buildpack-crails $*
fi

cd runtime

if [[ -f .git ]] ; then
else
  git init .
  heroku git:remote $*
  git pull heroku master
fi

git add .
git commit --amend -m "crails-docker/heroku deployment"
git push -f heroku master
