# deploy tools

##post-recieve

a post-recieve hook that clones/pulls what ever was just pushed to
$HOME/heads/project/branch|tag

## create remote

nah, better to copy the hook as well.
copy this package to the remote server and install into the path.
/usr/local/node_modules/deploy
then link the bin scripts to
/usr/local/bin

then it will be possible to run
ssh root@server deploy-init proj which will create a git repo, with a install hook.
```
proj=`basename $PWD`
ssh root@server << HEREDOC
  mkdir $proj -p
  cd $proj
  git init --bare || true
  ln -s `which post-recieve` hooks/post-recieve
HEREDOC
git add remote deploy 

```

## deploy

```
# deploy script -c COMMAND


``` 