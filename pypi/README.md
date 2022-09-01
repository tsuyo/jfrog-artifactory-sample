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
(venv) $ python3 -m pip install -r requirements.txt
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
Create repos
```
$ jf c use $SERVER_ID
$ jf-quick-setup -k hello -t pypi
```
Configure JFrog CLI to use the created virtual repo ("hello-pypi")
```
$ jf pipc --repo-resolve=hello-pypi --server-id-resolve=$SERVER_ID
```
Create a virtual environment
```
$ python3 -m venv venv
$ . venv/bin/activate
(venv) $ python3 -m pip install --upgrade pip
```

### Resolve dependencies
```
(venv) $ jf pip install -r requirements.txt --build-name=hello-pypi-build --build-number=1 --no-cache-dir --force-reinstall
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
(venv) $ python3 -m twine upload --repository-url $JFROG_PLATFORM_URL/artifactory/api/pypi/hello-pypi dist/*
...
Enter your username: admin
Enter your password: 
```

Build Info
```
(venv) $ jf rt bce hello-pypi-build 1
(venv) $ jf rt bag hello-pypi-build 1
(venv) $ jf rt bp hello-pypi-build 1
```

### Test
```
(venv) $ jf pip install tsuyo-hello
(venv) $ python3 -m hello
```

### Clean up
Delete repos if you want
```
$ jf-quick-teardown -k hello -t pypi
```

## Automation
You can use `jf-pip-build` command in jfrog-tools to automate this procedure
```
$ jf-pip-build -s SERVER_ID -r hello-pypi hello-pypi-build 1
```
