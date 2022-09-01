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
$ jf c use $SERVER_ID
$ jf-quick-setup -k hello -t npm
```
Configure JFrog CLI to use the created virtual repo ("hello-npm")
```
$ jf npmc --repo-deploy=hello-npm --repo-resolve=hello-npm --server-id-deploy=$SERVER_ID --server-id-resolve=$SERVER_ID
```

### Resolve dependencies
```
$ jf npm i --build-name=hello-npm-build --build-number=1
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
$ jf npm publish --build-name=hello-npm-build --build-number=1
```

Build Info
```
$ jf rt bce hello-npm-build 1
$ jf rt bag hello-npm-build 1
$ jf rt bp hello-npm-build 1
```

### Test
```
$ jf npm i tsuyo-hello-npm
$ jf npm uninstall tsuyo-hello-npm
```

### Clean up
Delete repos if you want
```
$ jf-quick-teardown -k hello -t npm
```

## Automation
You can use `jf-npm-build` command in jfrog-tools to automate this procedure
```
$ jf-npm-build -s $SERVER_ID -r hello-npm hello-npm-build 1
```
