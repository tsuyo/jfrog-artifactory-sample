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
Choose the repos for JFrog CLI (select the last repo ("hello-maven" in the above case) for all questions below)
```
$ cd ..
$ docker login platform.dev.gcp.tsuyo.org
$ docker build --build-arg URL=platform.dev.gcp.tsuyo.org/hello-docker -t platform.dev.gcp.tsuyo.org/hello-docker/hello:0.0.1 -f docker/Dockerfile .
$ docker push platform.dev.gcp.tsuyo.org/hello-docker/hello:0.0.1
```

## Clean Up
Delete repos once you finish
```
$ ../artifactory/delete_repo.sh hello docker
delete repos
[Info] Deleting repository hello-docker...
[Info] Done deleting repository.
[Info] Deleting repository hello-docker-local...
[Info] Done deleting repository.
[Info] Deleting repository hello-docker-remote...
[Info] Done deleting repository.
```