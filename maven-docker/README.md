# Hello Maven

## JFrog Artifactory Configuration
1. Create the following project
    - Project Name: hello
    - Project Key: hello
2. Create the following repos/registries under the project above
    - Local Repository
      - Repository Key: Maven -> [hello-]maven-local
        - Enable Indexing In Xray
      - Repository Key: Docker -> [hello-]docker-local
        - Enable Indexing In Xray
    - Remote Repository
      - Repository Key: Maven -> [hello-]maven-remote
        - URL: https://repo1.maven.org/maven2/ (default)
        - Enable Indexing In Xray
      - Repository Key: Docker -> [hello-]docker-remote
        - URL: https://registry-1.docker.io/(default)
        - Enable Indexing In Xray
    - Virtual Repository
      - Repository Key: Maven -> [hello-]maven
        - Repositories: [hello-]maven-local, [hello-]maven-remote
        - Default Deployment Repository: [hello-]maven-local
      - Repository Key: Docker -> [hello-]docker
        - Repositories: [hello-]docker-local, [hello-]docker-remote
        - Default Deployment Repository: [hello-]docker-local
3. Go to "[hello-]maven" -> Set Me Up -> Type password -> Click "Configure" tab -> Fill all entries (Releases, Snapshots, Plugin Releases, Plugin Snapshots) with "[hello-]maven" -> "Generate Settings" -> Download Snippet (settings.xml)
4. ~~Go to "[hello-]maven" -> Set Me Up -> Type password -> Click "Deploy" tab -> Copy a snippet to pom.xml~~

## Local Configuration
```
$ export ARTIFACTORY_HOST=platform.dev.gcp.tsuyo.org
$ vi pom.xml
<....>
 <properties>
    <java.version>11</java.version>
    <artifactory.url>platform.prod.tsuyo.org</artifactory.url> # use your artifactory url
  </properties>
$ vi Dockerfile
FROM platform.prod.tsuyo.org/hello-docker/openjdk:17-jdk-alpine # use your artifactory url
```
A Hello World App in Docker built with Maven
```
$ docker login $ARTIFACTORY_HOST
$ ./mvnw -s settings.xml deploy
```
or complete version
```
$ docker login platform.prod.tsuyo.org # use your artifactory url
$ ./mvnw -s settings.xml -U dependency:purge-local-repository clean deploy
```