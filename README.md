# Common Configuration

## JFrog CLI Configuration
```
$ jf c add
Server ID: dev.gcp
JFrog platform URL: https://platform.dev.gcp.tsuyo.org          
JFrog access token (Leave blank for username and password/API key): 
JFrog username: admin
JFrog password or API key: 
Is the Artifactory reverse proxy configured to accept a client certificate? (y/n) [n]? 
```

## JFrog Artifactory Configuration
Create a project
```
$ cd artifactory
$ ./create_project.sh -s dev.gcp -p hello
artifactory token: 
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
```
Delete a project (if something goes wrong or you no longer need it)
```
$ ./delete_project.sh -s dev.gcp -p test
artifactory token: 
delete project
```