#!/bin/bash -e

cd `dirname $0`

if [[ -z $CRAILS_BRANCH ]] ; then
  CRAILS_BRANCH="master"
fi

HASH=`git ls-remote git://github.com/Plaristote/crails.git | grep "refs/heads/$CRAILS_BRANCH" | cut -d'	' -f1`

echo "Using crails version: $HASH"

sed -e 's/git checkout [a-z0-9]*/git checkout '$HASH'/g' crails.sh > .tmpfile
mv .tmpfile crails.sh
chmod +x crails.sh
