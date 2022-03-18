# Hello Go

## Development Flow without JFrog

### Resolve dependencies
```
$ go install
```

### Build
```
$ go build
```

### Run
```
$ go run main.go
```

## Development Flow with JFrog

### Preparation
Create repos under a project ("hello" in this case)
```
$ jf c use dev.gcp
$ ../artifactory/create_repo.sh -s dev.gcp -u admin -p hello go ./artifactory
```
Configure JFrog CLI to use the created virtual repo ("hello-go")
```
$ jf goc
Resolve dependencies from Artifactory? (y/n) [y]? 
Set Artifactory server ID [dev.gcp]: 
Set repository for dependencies resolution (press Tab for options): hello-go
Deploy project artifacts to Artifactory? (y/n) [y]? 
Set Artifactory server ID [dev.gcp]: 
Set repository for artifacts deployment (press Tab for options): hello-go
21:54:00 [Info] go build config successfully created.
```

### Resolve dependencies
```
$ jf go install
```

### Build
```
$ jf go build --project=hello --build-name=hello-go-build --build-number=1
```

### Run
```
$ jf go run main.go
```

### Publish
Artifact
```
$ jf gp v1.0.0 --project=hello --build-name=hello-go-build --build-number=1
```

Build Info
```
$ jf rt bce --project=hello hello-go-build 1
$ jf rt bag --project=hello hello-go-build 1 ..
$ jf rt bp --project=hello hello-go-build 1
```

### Clean up
Delete repos if you want
```
$ ../artifactory/delete_repo.sh hello go
```

## Automation
You can use the following script to automate this procedure
```
$ ./run.sh hello hello-go-build 1 v1.0.0
```
