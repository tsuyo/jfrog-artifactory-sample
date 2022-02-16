# Hello NPM

## JFrog Artifactory Configuration
Create repos under a project
```
$ ../artifactory/create_repo.sh -s dev.gcp -u admin -p hello npm ./artifactory
artifactory password or token for user <admin>: 
create repos (user: admin, server_id: dev.gcp, project: hello, repo_name: npm, repo_conf_dir: ./artifactory)
Successfully created repository 'hello-npm-local' 
Successfully created repository 'hello-npm-remote' 
Successfully created repository 'hello-npm' 
```

## Build and Deploy
Choose the repos for JFrog CLI (select the last repo ("hello-npm" in the above case) for all questions below)
```
$ jfrog npmc
Resolve dependencies from Artifactory? (y/n) [y]? 
Set Artifactory server ID [dev.gcp]: 
Set repository for dependencies resolution (press Tab for options): hello-npm
Deploy project artifacts to Artifactory? (y/n) [y]? 
Set Artifactory server ID [dev.gcp]: 
Set repository for artifacts deployment (press Tab for options): hello-npm
15:33:30 [Info] npm build config successfully created.
$ jfrog c use dev.gcp
```
Build manually
```
$ npm cache clean --force # clear local cache (~/.npm) - might not be recommended, but jfrog cli might have an issue with the caches
$ jfrog npm ci --project=hello --build-name=hello-npm-build --build-number=1   # "npm ci" removes node_modules first
$ jfrog npm publish --project=hello --build-name=hello-npm-build --build-number=1
$ jfrog rt bce --project=hello hello-npm-build 1
$ jfrog rt bag --project=hello hello-npm-build 1 ..
$ jfrog rt bp --project=hello hello-npm-build 1
```
Or Build with script (the same as above)
```
$ ./build.sh hello hello-npm-build 1
```

## Clean Up
Delete repos once you finish
```
$ ../artifactory/delete_repo.sh hello npm
```
