#!/bin/bash -x

docker/shell -v -c package.sh

heroku config $* | grep LD_LIBRARY_PATH
if [[ $? != 0 ]] ; then
  heroku config:set LD_LIBRARY_PATH=/app/lib:/app/bin $*
  heroku config:set BUILDPACK_URL=https://github.com/crails-framework/heroku-buildpack-crails.git $*
fi

cd runtime

if [[ -f .git ]] ; then
  echo "git repository ready"
else
  git init .
  heroku git:remote $*
  git pull heroku master
fi

commit_options=""
if [[ -f .git/logs/HEAD ]] ; then
  commit_options="--amend"
fi

git add .
git commit $commit_options -m "crails-docker/heroku deployment"
git push -f heroku master
