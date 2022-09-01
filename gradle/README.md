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
$ jf c use $SERVER_ID
$ jf-quick-setup -k hello -t gradle
```
Configure JFrog CLI to use the created virtual repo ("hello-gradle")
```
$ jf gradlec --repo-deploy=hello-gradle --repo-resolve=hello-gradle --server-id-deploy=$SERVER_ID --server-id-resolve=$SERVER_ID
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
$ jf gradle artifactoryPublish --build-name=hello-gradle-build --build-number=1
```

Build Info
```
$ jf rt bce hello-gradle-build 1
$ jf rt bag hello-gradle-build 1
$ jf rt bp hello-gradle-build 1
```

### Clean up
Delete repos if you want
```
$ jf-quick-teardown -k hello -t gradle
```

## Automation
You can use `jf-gradle-build` command in jfrog-tools to automate this procedure
```
$ jf-gradle-build -s $SERVER_ID -r hello-gradle hello-gradle-build 1
```
