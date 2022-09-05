# Hello Rust

## Development Flow without JFrog

### Resolve dependencies
```
$ cargo fetch
```

### Build
```
$ cargo build
```

### Run
```
$ cargo run
```


## Development Flow with JFrog

### Preparation
Create local & remote registries in Artifactory UI
- New Local Repository
  - Package Type: Cargo
  - Repository Key: test-cargo-local
  - Cargo Settings: Check "Allow anonymous download and search"
- New Remote Repository
  - Package Type: Cargo
  - Repository Key: test-cargo-remote
  - Cargo Settings: Check "Allow anonymous download and search"

Configure Cargo CLI
```
$ mkdir .cargo
$ vi .cargo/config.toml
# Makes artifactory the default registry and saves passing --registry parameter
[registry]
default = "artifactory-remote"

[registries.artifactory-local]
index = "https://devtsuyo.jfrog.io/artifactory/git/test-cargo-local.git"

[registries.artifactory-remote]
index = "https://devtsuyo.jfrog.io/artifactory/git/test-cargo-remote.git"


# For sending credentials in git requests.
# Not required if anonymous access is enabled
[net]
git-fetch-with-cli = true


# Add these 2 sections for resolving dependencies from Artifactory
[source.artifactory-remote]
registry = "https://devtsuyo.jfrog.io/artifactory/git/test-cargo-remote.git"

[source.crates-io]
replace-with = "artifactory-remote"
```

### Resolve dependencies
```
$ cargo fetch
```

### Build
```
$ cargo build
```

### Run
```
$ cargo run
```

### Publish
```
$ cargo publish --registry=artifactory-local --token "Bearer <jfrog_access_token>"
```

### Warning
If you delete contents from cargo registries, you might need to reindex for that registries
