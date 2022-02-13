# Hello Docker

## JFrog Artifactory Configuration
Create repos under a project
```
$ ../artifactory/create_repo.sh -s dev.gcp -u admin -p hello docker ./artifactory
artifactory password or token for user <admin>: 
create repos (user: admin, server_id: dev.gcp, project: hello, repo_name: docker, repo_conf_dir: ./artifactory)
Successfully created repository 'hello-docker-local' 
Successfully created repository 'hello-docker-remote' 
Successfully created repository 'hello-docker'
```

## Build and Deploy
Build manually
```
$ docker login platform.dev.gcp.tsuyo.org
$ docker build --no-cache --build-arg REG=platform.dev.gcp.tsuyo.org/hello-docker -t platform.dev.gcp.tsuyo.org/hello-docker/hello:0.0.1 .
$ jfrog rt dp platform.dev.gcp.tsuyo.org/hello-docker/hello:0.0.1 hello-docker --project=hello --build-name=hello-docker-build --build-number=1
$ jfrog rt bce --project=hello hello-docker-build 1
$ jfrog rt bag --project=hello hello-docker-build 1 ..
$ jfrog rt bp --project=hello hello-docker-build 1
```
Or Build with script (the same as above)
```
$ ./build.sh hello hello-docker-build 1 platform.dev.gcp.tsuyo.org hello-docker hello 0.0.1
```

## Clean Up
Delete repos once you finish
```
$ ../artifactory/delete_repo.sh hello docker
```