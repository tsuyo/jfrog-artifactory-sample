# Hello Maven

## JFrog Artifactory Configuration
Create repos under a project
```
$ ../artifactory/create_repo.sh -s dev.gcp -u admin -p hello maven ./artifactory
artifactory password or token for user <admin>: 
create repos (user: admin, server_id: dev.gcp, project: hello, repo_name: maven, repo_conf_dir: ./artifactory)
Successfully created repository 'hello-maven-local' 
Successfully created repository 'hello-maven-remote' 
Successfully created repository 'hello-maven'
```

## Build and Deploy
Choose the repos for JFrog CLI (select the last repo ("hello-maven" in the above case) for all questions below)
```
$ jfrog mvnc
Resolve dependencies from Artifactory? (y/n) [y]? 
Set Artifactory server ID [repo21]: dev.gcp
Set resolution repository for release dependencies (press Tab for options): hello-maven
Set resolution repository for snapshot dependencies (press Tab for options): hello-maven
Deploy project artifacts to Artifactory? (y/n) [y]? 
Set Artifactory server ID [repo21]: dev.gcp
Set repository for release artifacts deployment (press Tab for options): hello-maven
Set repository for snapshot artifacts deployment (press Tab for options): hello-maven
Would you like to filter out some of the deployed artifacts? (y/n) [n]? 
[Info] maven build config successfully created.
$ jfrog c use dev.gcp
```
```
$ jfrog mvn clean deploy --project=hello --build-name=hello-maven-manual-build --build-number=1
$ jfrog rt bce --project=hello hello-maven-manual-build 1
$ jfrog rt bag --project=hello hello-maven-manual-build 1 ..
$ jfrog rt bp --project=hello hello-maven-manual-build 1
```
To completely delete local caches as well, use the following command instead
```
$ jfrog mvn -U dependency:purge-local-repository clean deploy --project=hello --build-name=hello-maven-manual-build --build-number=1
```

## Clean Up
Delete repos once you finish
```
$ ../artifactory/delete_repo.sh hello maven
delete repos
[Info] Deleting repository hello-maven...
[Info] Done deleting repository.
[Info] Deleting repository hello-maven-local...
[Info] Done deleting repository.
[Info] Deleting repository hello-maven-remote...
[Info] Done deleting repository.
```
