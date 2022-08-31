# Hello Docker

## Development Flow without JFrog

### Preparation
```
$ docker login
```

### Resolve dependencies
```
$ docker pull golang:alpine
```

### Build
```
$ docker build --no-cache -t hello-docker:1.0.0 .
```

### Run
```
$ docker run -it -p 8080:8080 hello-docker:1.0.0
```

### Publish
Remote

Create an account on [Docker Hub](https://hub.docker.com/)
```
$ docker tag hello-docker:1.0.0 $DOCKER_ID/hello-docker:1.0.0
$ docker push $DOCKER_ID/hello-docker:1.0.0
```

### Test
```
$ docker pull $DOCKER_ID/hello-docker:1.0.0
```

## Development Flow with JFrog

### Preparation
Create repos
```
$ jf c use $SERVER_ID
$ jf-quick-setup -k hello -t docker
```
Login to JFrog Platform
```
$ docker login $JFROG_PLATFORM_URL
```

### Resolve dependencies
```
$ docker pull $JFROG_PLATFORM_URL/hello-docker/golang:alpine
```

### Build
```
$ docker build --no-cache --build-arg REG=$JFROG_PLATFORM_URL/hello-docker -t $JFROG_PLATFORM_URL/hello-docker/hello-docker:1.0.0 .
```

### Run
```
$ docker run -it -p 8080:8080 $JFROG_PLATFORM_URL/hello-docker/hello-docker:1.0.0
```

### Publish
Artifact
```
$ jf docker push $JFROG_PLATFORM_URL/hello-docker/hello-docker:1.0.0 --build-name=hello-docker-build --build-number=1
```

Build Info
```
$ jf rt bce hello-docker-build 1
$ jf rt bag hello-docker-build 1
$ jf rt bp hello-docker-build 1
```

### Test
```
docker pull $JFROG_PLATFORM_URL/hello-docker/hello-docker:1.0.0
```

### Clean up
Delete repos if you want
```
$ jf-quick-teardown -k hello -t docker
```

## Automation
You can use `jf-docker-build` command in jfrog-tools to automate this procedure
```
$ jf-docker-build -u $JFROG_PLATFORM_URL -r hello-docker -i hello-docker -v 1.0.0 hello-docker-build 1
```
