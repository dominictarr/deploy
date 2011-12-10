# deploy

tools to create setup a server for continous deployment via git push.

## deploy create simple|branches USER@HOST path

create a git repo on HOST at path

and add a remote named `deploy` in the currect git repo.

remote repos can be 'simple' or use 'branches'.

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

```