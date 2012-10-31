# deploy

tools to create setup a server for continous deployment via git push.

## basics

``` js
ssh user@host
npm install -g deploy
deploy init simple /path/to/repo

#(use absolute paths throughout)
exit
git remote add deploy ssh://user@host/path/to/repo

#push it real good
git push deploy master
```
Add an executable script named `update` to the root of your project.
It will be executed when you push your repo!

## deploy create simple|branches USER@HOST path

> okay, so I also added this thing to push to multiple branches.
> this is too complicated really, I will delete this feature...

create a git repo on HOST at path

and add a remote named `deploy` in the currect git repo.

remote repos can be 'simple' or use 'branches'.

> currently I recommend using `simple`

when you push to a git repo it will checkout master into ./
then run `./update`

if you use `deploy create branches ...` it will checkout 
each branch and tag into a seperate folder, and then run `./update`
_this will be very useful for split testing!_

```
  project/
    git/        #git stuff in here
    master/     #master 
    tag/        #tag
```

push to your new git repo with 

```
git push deploy [branch|--tags]

