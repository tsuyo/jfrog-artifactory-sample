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
Create repos
```
$ jf c use $SERVER_ID
$ jf-quick-setup -k hello -t maven
```
Configure JFrog CLI to use the created virtual repo ("hello-maven")
```
$ jf mvnc --repo-deploy-releases=hello-maven --repo-deploy-snapshots=hello-maven --repo-resolve-releases=hello-maven --repo-resolve-snapshots=hello-maven --server-id-deploy=$SERVER_ID --server-id-resolve=$SERVER_ID
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
$ jf mvn deploy --build-name=hello-maven-build --build-number=1
```

Build Info
```
$ jf rt bce hello-maven-build 1
$ jf rt bag hello-maven-build 1
$ jf rt bp hello-maven-build 1
```

### Clean Up
Delete repos if you want
```
$ jf-quick-teardown -k hello -t maven
```

## Automation
You can use `jf-mvn-build` command in jfrog-tools to automate this procedure
```
$ jf-mvn-build -s $SERVER_ID -r hello-maven hello-maven-build 1
```
