# Hello Go

## Development Flow without JFrog

### Resolve dependencies
```
$ go mod download
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
Create repos
```
$ jf c use $SERVER_ID
$ jf-quick-setup -k hello -t go
```
Configure JFrog CLI to use the created virtual repo ("hello-go")
```
$ jf goc --repo-deploy=hello-go --repo-resolve=hello-go --server-id-deploy=$SERVER_ID --server-id-resolve=$SERVER_ID
```

### Resolve dependencies
```
$ jf go mod download
```

### Build
```
$ jf go build --build-name=hello-go-build --build-number=1
```

### Run
```
$ jf go run main.go
```

### Publish
Artifact
```
$ jf gp v1.0.0 --build-name=hello-go-build --build-number=1
```

Build Info
```
$ jf rt bce hello-go-build 1
$ jf rt bag hello-go-build 1
$ jf rt bp hello-go-build 1
```

### Clean up
Delete repos if you want
```
$ jf-quick-teardown -k hello -t go
```

## Automation
You can use `jf-go-build` command in jfrog-tools to automate this procedure
```
$ jf-go-build -s $SERVER_ID -r hello-go -v v1.0.0 hello-go-build 1
```
