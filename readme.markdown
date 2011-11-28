# deploy

tools to create setup a server for continous deployment via git push.

## deploy create USER@HOST [projectname]

create a git repo on HOST with projectname (or the basename of current dir)

and create a remote named `deploy` in the currect git repo.

the remote repo will be setup with a post-receive hook that will checkout every branch and tag.
this will be very useful for split testing.

```
  project/
    git/        #git stuff in here
    master/     #master 
    tag/        #tag
```

push to your new git repo with 

```
git push deploy [branch|--tags]

