list=`echo $(jfrog c s | grep "Server ID:" | awk '{print $3}') | sed "s/ /, /g"`
read -p "server id [$list]: " server_id
read -p "user: " user
read -sp "token: " token
echo ""
read -p "prefix: " prefix

url=`jfrog c s $server_id | head -2 | tail -1 | awk '{print $4}'`
url=${url::-1}

echo "create repos"
cat maven-local.json |\
  curl -u ${user}:${token} -X PUT -H "Content-Type: application/json" "${url}/artifactory/api/repositories/${prefix}-maven-local" -d @-
cat maven-remote.json |\
  curl -u ${user}:${token} -X PUT -H "Content-Type: application/json" "${url}/artifactory/api/repositories/${prefix}-maven-remote" -d @-
sed "s/_PREFIX/${prefix}/g" maven.json |\
  curl -u ${user}:${token} -X PUT -H "Content-Type: application/json" "${url}/artifactory/api/repositories/${prefix}-maven" -d @-
