#!/usr/bin/env bash

pushd `dirname $BASH_SOURCE`

set -e

. ./assert.sh

plan 6
deploy=`readlink -e ../deploy`

rm -rf /tmp/branches-deploy-test

timestamp=`date +%s`
tmpremote=/tmp/branches-deploy-test/"$timestamp"_remote
tmpdir=/tmp/branches-deploy-test/"$timestamp"

mkdir -p "$tmpdir"
cd "$tmpdir"
git init
echo '#!/usr/bin/env bash
  echo UPDATE_HOOK `pwd` `date`
  ' > update
chmod +x update

$deploy create branches localhost "$tmpremote"

assert test -e "$tmpremote"/git/hooks/post-receive

git status
date >> times.log
git add *
git commit * -m 'commit 1'
echo 'commited one file'
git status
git remote -v
git push deploy master

assert test -e $tmpremote/master
#echo expected times.log
assert ls $tmpremote/master
assert diff times.log $tmpremote/master/times.log

#create a tag
git tag -a master_stable -m 'master_stable tag'
git push deploy --tags

assert diff times.log $tmpremote/master_stable/times.log

#git checkout -b testbranch
#git branch

#exit 0

date >> times.log
git add times.log
git commit times.log -m 'commit 2'

date >> times.log
git add times.log
git commit times.log -m 'commit 3'

#date >> times.log
#git add times.log
#git commit times.log -m 'commit 4'

git push deploy master
assert diff times.log $tmpremote/master/times.log

echo end
