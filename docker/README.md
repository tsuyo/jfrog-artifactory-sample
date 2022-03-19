# Hello Docker

## Development Flow without JFrog

### Preparation
```
$ docker login
```

### Resolve dependencies
N/A

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
$ docker tag hello-docker:1.0.0 <docker_id>/hello-docker:1.0.0
$ docker push <docker_id>/hello-docker:1.0.0
```

### Test
```
$ docker pull <docker_id>/hello-docker:1.0.0
```

## Development Flow with JFrog

### Preparation
Create repos under a project ("hello" in this case)
```
$ jf c use dev.gcp
$ ../artifactory/create_repo.sh -s dev.gcp -u admin -p hello docker ./artifactory
```
Login to JFrog Platform
```
$ docker login <jfrog_platform_url>
```

### Resolve dependencies
N/A

### Build
```
$ docker build --no-cache --build-arg REG=<jfrog_platform_url>/hello-docker -t hello-docker:1.0.0 .
```

### Run
```
$ docker run -it -p 8080:8080 hello-docker:1.0.0
```

### Publish
Artifact
```
$ docker tag hello-docker:1.0.0 <jfrog_platform_url>/hello-docker/hello-docker:1.0.0
$ jf docker push <jfrog_platform_url>/hello-docker/hello-docker:1.0.0 --project=hello --build-name=hello-docker-build --build-number=1
```

Build Info
```
$ jf rt bce --project=hello hello-docker-build 1
$ jf rt bag --project=hello hello-docker-build 1 ..
$ jf rt bp --project=hello hello-docker-build 1
```

### Test
```
docker pull <jfrog_platform_url>/hello-docker/hello-docker:1.0.0
```

### Clean up
Delete repos if you want
```
$ ../artifactory/delete_repo.sh hello docker
```

## Automation
You can use the following script to automate this procedure
```
$ ./run.sh hello hello-docker-build 1 platform.dev.gcp.tsuyo.org hello-docker hello-docker 1.0.0
```
