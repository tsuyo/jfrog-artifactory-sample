# Hello Maven

## JFrog CLI Configuration
```
$ jfrog c add
Server ID: dev.gcp
JFrog platform URL: https://platform.dev.gcp.tsuyo.org          
JFrog access token (Leave blank for username and password/API key): 
JFrog username: admin
JFrog password or API key: 
Is the Artifactory reverse proxy configured to accept a client certificate? (y/n) [n]? 
```

## JFrog Artifactory Configuration
Create a project & repos under the project
```
$ cd maven/artifactory
$ ./repo_create.sh
server id [prod, repo21, dev.gcp]: dev.gcp
token: 
project: hello
create project
{
  "display_name" : "hello",
  "admin_privileges" : {
    "manage_members" : true,
    "manage_resources" : true,
    "index_resources" : true
  },
  "storage_quota_bytes" : -1,
  "soft_limit" : false,
  "storage_quota_email_notification" : true,
  "project_key" : "hello"
}
create repos
Successfully created repository 'hello-maven-local' 
Successfully created repository 'hello-maven-remote' 
Successfully created repository 'hello-maven'
```
Choose the repos for JFrog CLI (select the last repo ("hello-maven" in the above case) for all questions below)
```
$ cd ..
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

## Build and Deploy
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