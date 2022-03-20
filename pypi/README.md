# Hello PyPI

## Development Flow without JFrog

### Preparation
Create a virtual environment
```
$ python3 -m venv venv
$ . venv/bin/activate
(venv) $ python3 -m pip install --upgrade pip
```

### Resolve dependencies
```
(venv) $ python3 -m pip install Babel
```

### Build
```
(venv) $ python3 -m pip install --upgrade setuptools wheel
(venv) $ python3 setup.py sdist bdist_wheel
```

### Run
```
(venv) $ PYTHONPATH=build/lib python3 -m hello
```

### Publish
Local
```
(venv) $ pip install -e .
```

Remote

Create an account on [PyPI](https://pypi.org/)
```
(venv) $ python3 -m pip install --upgrade twine
(venv) $ python3 -m twine upload dist/*
```

### Test
```
(venv) $ pip uninstall tsuyo-hello # uninstall a package if it's previously installed
(venv) $ pip install tsuyo-hello
(venv) $ python3 -m hello
```

## Development Flow with JFrog

### Preparation
Create repos under a project ("hello" in this case)
```
$ jf c use dev.gcp
$ ../artifactory/create_repo.sh -s dev.gcp -u admin -p hello pypi ./artifactory
```
Configure JFrog CLI to use the created virtual repo ("hello-pypi")
```
$ jf pipc
Resolve dependencies from Artifactory? (y/n) [y]? 
Set Artifactory server ID [dev.gcp]: 
Set repository for dependencies resolution (press Tab for options): hello-pypi
```
Create a virtual environment
```
$ python3 -m venv venv
$ . venv/bin/activate
$ python3 -m pip install --upgrade pip
```

### Resolve dependencies
```
(venv) $ jf pip install Babel --project=hello --build-name=hello-pypi-build --build-number=1 --no-cache-dir --force-reinstall
```

### Build
```
(venv) $ python3 -m pip install --upgrade setuptools wheel
(venv) $ python3 setup.py sdist bdist_wheel
```

### Run
```
(venv) $ PYTHONPATH=build/lib python3 -m hello
```

### Publish
Artifact
```
(venv) $ python3 -m pip install --upgrade twine
(venv) $ python3 -m twine upload --repository-url https://platform.dev.gcp.tsuyo.org/artifactory/api/pypi/hello-pypi dist/*
Uploading distributions to https://platform.dev.gcp.tsuyo.org/artifactory/api/pypi/hello-pypi
Enter your username: admin
Enter your password: 
```

Build Info
```
(venv) $ jf rt bce --project=hello hello-pypi-build 1
(venv) $ jf rt bag --project=hello hello-pypi-build 1 ..
(venv) $ jf rt bp --project=hello hello-pypi-build 1
```

### Test
```
(venv) $ jf pip install tsuyo-hello
(venv) $ python3 -m hello
```

### Clean up
Delete repos if you want
```
$ ../artifactory/delete_repo.sh hello pypi
```

## Automation
You can use the following script to automate this procedure
```
$ ./run.sh -s dev.gcp -r pypi hello hello-pypi-build 1
```
