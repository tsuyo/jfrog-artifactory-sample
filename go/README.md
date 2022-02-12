# Hello Go

## JFrog Artifactory Configuration
Create repos under a project
```
$ ../artifactory/create_repo.sh -s dev.gcp -u admin -p hello go ./artifactory
artifactory password or token for user <admin>: 
create repos (user: admin, server_id: dev.gcp, project: hello, repo_name: go, repo_conf_dir: ./artifactory)
Successfully created repository 'hello-go-local' 
Successfully created repository 'hello-go-remote' 
Successfully created repository 'hello-go' 
```

## Build and Deploy
Choose the repos for JFrog CLI (select the last repo ("hello-go" in the above case) for all questions below)
```
$ jfrog goc
Resolve dependencies from Artifactory? (y/n) [y]? 
Set Artifactory server ID [dev.gcp]: 
Set repository for dependencies resolution (press Tab for options): hello-go
Deploy project artifacts to Artifactory? (y/n) [y]? 
Set Artifactory server ID [dev.gcp]: 
Set repository for artifacts deployment (press Tab for options): hello-go
21:54:00 [Info] go build config successfully created.
$ jfrog c use dev.gcp
$ sudo rm -fr $GOPATH/pkg/mod # delete local caches to confirm every dependency is resolved via artifactory
```
Build manually
```
$ jfrog go build --project=hello --build-name=hello-go-build --build-number=1
$ jfrog gp v1.0.0 --project=hello --build-name=hello-go-build --build-number=1
$ jfrog rt bce --project=hello hello-go-build 1
$ jfrog rt bag --project=hello hello-go-build 1 ..
$ jfrog rt bp --project=hello hello-go-build 1
```
Or Build with script (the same as above)
```
$ ./build.sh hello hello-go-build 1 v1.0.0
```

## Clean Up
Delete repos once you finish
```
$ ../artifactory/delete_repo.sh hello go
delete repos
22:51:54 [Info] Deleting repository hello-go...
22:51:57 [Info] Done deleting repository.
22:51:57 [Info] Deleting repository hello-go-local...
22:51:59 [Info] Done deleting repository.
22:52:00 [Info] Deleting repository hello-go-remote...
22:52:02 [Info] Done deleting repository.
```
