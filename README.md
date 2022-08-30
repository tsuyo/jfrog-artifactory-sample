# Common Configuration

## Prerequisites
Install JFrog CLI and JFrog Tools
```
$ brew install jfrog-cli
$ brew tap tsuyo/tap
$ brew install jfrog-tools
```

## JFrog CLI Configuration
```
$ jf c add $SERVER_ID --url=$ARTIFACTORY_URL --user=$ARTIFACTORY_USER --password=$ARTIFACTORY_PASSWORD --interactive=false
```

## JFrog Artifactory Configuration
If you want to use a project in JFrog Artifactory, create one (e.g. "hello")
```
$ jf-create-proj -s $SERVER_ID -p hello
artifactory token: 
```
Delete a project (if something goes wrong or you no longer need it)
```
$ jf-delete-proj -s $SERVER_ID -p hello
artifactory token: 
```