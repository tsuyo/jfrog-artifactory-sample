# Hello NPM

## Development Flow without JFrog

### Resolve dependencies
```
$ npm i
```

### Build
N/A

### Run
```
$ npm start
```

### Publish
Remote

Create an account on [npmjs.com](https://npmjs.com/)
```
$ npm login
$ npm publish
```

### Test
```
$ npm i tsuyo-hello-npm
```

## Development Flow with JFrog

### Preparation
Create repos under a project ("hello" in this case)
```
$ jf c use dev.gcp
$ ../artifactory/create_repo.sh -s dev.gcp -u admin -p hello npm ./artifactory
```
Configure JFrog CLI to use the created virtual repo ("hello-npm")
```
$ jf npmc
Resolve dependencies from Artifactory? (y/n) [y]? 
Set Artifactory server ID [dev.gcp]: 
Set repository for dependencies resolution (press Tab for options): hello-npm
Deploy project artifacts to Artifactory? (y/n) [y]? 
Set Artifactory server ID [dev.gcp]: 
Set repository for artifacts deployment (press Tab for options): hello-npm
15:33:30 [Info] npm build config successfully created.
```

### Resolve dependencies
```
$ jf npm i --project=hello --build-name=hello-npm-build --build-number=1
```

### Build
N/A

### Run
```
$ npm start
```

### Publish
Artifact
```
$ jf npm publish --project=hello --build-name=hello-npm-build --build-number=1
```

Build Info
```
$ jf rt bce --project=hello hello-npm-build 1
$ jf rt bag --project=hello hello-npm-build 1 ..
$ jf rt bp --project=hello hello-npm-build 1
```

### Test
```
$ jf npm i tsuyo-hello-npm
$ jf npm uninstall tsuyo-hello-npm
```

### Clean up
Delete repos if you want
```
$ ../artifactory/delete_repo.sh hello npm
```

## Automation
You can use the following script to automate this procedure
```
$ ./run.sh hello hello-npm-build 1
```
