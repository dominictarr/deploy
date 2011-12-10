#!/usr/bin/env bash

pushd `dirname $BASH_SOURCE`

#set -e

. ./assert.sh

plan 5
deploy=`readlink -e ../deploy`

rm -rf /tmp/simple-deploy-test

timestamp=`date +%s`
tmpremote=/tmp/simple-deploy-test/"$timestamp"_remote
tmpdir=/tmp/simple-deploy-test/"$timestamp"


mkdir -p "$tmpdir"
pushd "$tmpdir"
echo '#!/usr/bin/env bash
  echo UPDATE_HOOK `pwd` `date`
  ' > update
chmod +x update
git init

$deploy create simple localhost "$tmpremote"

assert test -e $tmpremote/.git/hooks/post-receive

#git remote add deploy "$tmpremote"

date >> times.log
git add *
assert git commit * -m 'commit 1'
git push deploy master

assert test -e $tmpremote/times.log
assert diff times.log $tmpremote/times.log

date >> times.log
date >> times.log

git commit times.log -m 'commit 2'
git push deploy master

assert diff times.log $tmpremote/times.log
echo end
