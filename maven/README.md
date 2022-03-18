# Hello Maven

## Development Flow without JFrog

### Resolve dependencies
```
$ mvn dependency:resolve
```

### Build
```
$ mvn clean package
```

### Run
```
$ mvn exec:java -Dexec.mainClass=dev.tsuyo.hello.HelloWorld
```

### Publish
Local
```
$ mvn install
```

## Development Flow with JFrog

### Preparation
Create repos under a project ("hello" in this case)
```
$ jf c use dev.gcp
$ ../artifactory/create_repo.sh -s dev.gcp -u admin -p hello maven ./artifactory
```

Configure JFrog CLI to use the created virtual repo ("hello-maven")
```
$ jf mvnc
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
```

### Resolve dependencies
```
$ jf mvn dependency:resolve
```

### Build
```
$ jf mvn clean package
```

### Run
```
$ jf mvn exec:java -Dexec.mainClass=dev.tsuyo.hello.HelloWorld
```

### Publish
Artifact
```
$ jf mvn deploy --project=hello --build-name=hello-maven-build --build-number=1
```

Build Info
```
$ jf rt bce --project=hello hello-maven-build 1
$ jf rt bag --project=hello hello-maven-build 1 ..
$ jf rt bp --project=hello hello-maven-build 1
```

### Clean Up
Delete repos if you want
```
$ ../artifactory/delete_repo.sh hello maven
```

## Automation
You can use the following script to automate this procedure
```
$ ./run.sh hello hello-maven-build 1
```
