# Hello Maven

## JFrog Artifactory Configuration
1. Create the following project
    - Project Name: hello
    - Project Key: hello
2. Create the following repos/registries under the project above
    - Local Repository
      - Repository Key: Maven -> [hello-]maven-local
        - Enable Indexing In Xray
    - Remote Repository
      - Repository Key: Maven -> [hello-]maven-remote
        - URL: https://repo1.maven.org/maven2/ (default)
        - Enable Indexing In Xray
    - Virtual Repository
      - Repository Key: Maven -> [hello-]maven
        - Repositories: [hello-]maven-local, [hello-]maven-remote
        - Default Deployment Repository: [hello-]maven-local
3. Go to "[hello-]maven" -> Set Me Up -> Type password -> Click "Configure" tab -> Fill all entries (Releases, Snapshots, Plugin Releases, Plugin Snapshots) with "[hello-]maven" -> "Generate Settings" -> Download Snippet (settings.xml)

## Local Configuration
```
$ export ARTIFACTORY_HOST=platform.dev.gcp.tsuyo.org
$ vi pom.xml
<....>
 <properties>
    <java.version>11</java.version>
    <artifactory.url>platform.prod.tsuyo.org</artifactory.url> # use your artifactory url
  </properties>
```
A Hello World App built with Maven
```
$ ./mvnw -s settings.xml deploy
```
or complete version
```
$ ./mvnw -s settings.xml -U dependency:purge-local-repository clean deploy
```