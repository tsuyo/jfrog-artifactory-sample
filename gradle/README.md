# Hello Gradle

## JFrog Artifactory Configuration
Create repos under a project
```
$ ../artifactory/create_repo.sh -s dev.gcp -u admin -p hello gradle ./artifactory
artifactory password or token for user <admin>: 
create repos (user: admin, server_id: dev.gcp, project: hello, repo_name: gradle, repo_conf_dir: ./artifactory)
Successfully created repository 'hello-gradle-local' 
Successfully created repository 'hello-gradle-remote' 
Successfully created repository 'hello-gradle'
```

## Build and Deploy
Choose the repos for JFrog CLI (select the last repo ("hello-gradle" in the above case) for all questions below)
```
$ jfrog gradlec
Resolve dependencies from Artifactory? (y/n) [y]? 
Set Artifactory server ID [dev.gcp]: 
Set repository for dependencies resolution (press Tab for options): hello-gradle
Deploy project artifacts to Artifactory? (y/n) [y]? 
Set Artifactory server ID [dev.gcp]: 
Set repository for artifacts deployment (press Tab for options): hello-gradle
Deploy Maven descriptors? (y/n) [n]? 
Deploy Ivy descriptors? (y/n) [n]? 
Is the Gradle Artifactory Plugin already applied in the build script? (y/n) [n]? 
Use Gradle wrapper? (y/n) [n]? 
[Info] gradle build config successfully created.
$ jfrog c use dev.gcp
$ rm -fr ~/.gradle # delete local caches to confirm every dependency is resolved via artifactory
```
Build manually
```
$ jfrog gradle clean artifactoryPublish --project=hello --build-name=hello-gradle-build --build-number=1
$ jfrog rt bce --project=hello hello-gradle-build 1
$ jfrog rt bag --project=hello hello-gradle-build 1 ..
$ jfrog rt bp --project=hello hello-gradle-build 1
```
Or Build with script (the same as above)
```
$ ./build.sh hello hello-gradle-build 1
```

## Clean Up
Delete repos once you finish
```
$ ../artifactory/delete_repo.sh hello gradle
delete repos
[Info] Deleting repository hello-gradle...
[Info] Done deleting repository.
[Info] Deleting repository hello-gradle-local...
[Info] Done deleting repository.
[Info] Deleting repository hello-gradle-remote...
[Info] Done deleting repository.
```
