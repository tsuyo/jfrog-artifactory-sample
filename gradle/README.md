# Hello Gradle

## Development Flow without JFrog

### Resolve dependencies
```
$ gradle dependencies # download pom only
```

### Build
```
$ gradle clean build
```

### Run
```
$ gradle run
```

### Publish
Local
```
$ gradle publishToMavenLocal
```

## Development Flow with JFrog

### Preparation
Create repos under a project ("hello" in this case)
```
$ jf c use dev.gcp
$ ../artifactory/create_repo.sh -s dev.gcp -u admin -p hello gradle ./artifactory
```
Configure JFrog CLI to use the created virtual repo ("hello-gradle")
```
$ jf gradlec
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
```

### Resolve dependencies
```
$ jf gradle dependencies # download pom only
```

### Build
```
$ jf gradle --info clean build
```

### Run
```
$ jf gradle run
```

### Publish
Artifact
```
$ jf gradle artifactoryPublish --project=hello --build-name=hello-gradle-build --build-number=1
```

Build Info
```
$ jf rt bce --project=hello hello-gradle-build 1
$ jf rt bag --project=hello hello-gradle-build 1 ..
$ jf rt bp --project=hello hello-gradle-build 1
```

### Clean up
Delete repos if you want
```
$ ../artifactory/delete_repo.sh hello gradle
```

## Automation
You can use the following script to automate this procedure
```
$ ./run.sh hello hello-gradle-build 1
```
