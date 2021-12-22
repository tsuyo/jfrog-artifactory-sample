list=`echo $(jfrog c s | grep "Server ID:" | awk '{print $3}') | sed "s/ /, /g"`
read -p "server id [$list]: " server_id
read -sp "token: " token
echo ""
read -p "project: " project

url=`jfrog c s $server_id | head -2 | tail -1 | awk '{print $4}'`
url=${url::-1}

echo "create project"
curl -H "Content-Type: application/json; charset=UTF-8" -H "Authorization: Bearer ${token}" \
  -X POST "${url}/access/api/v1/projects" -d "{\"display_name\": \"${project}\", \"project_key\": \"${project}\"}"
echo ""

echo "create repos"
sed "s/_PROJECT/${project}/g" maven-local.json |\
  curl -u admin:${token} -X PUT -H "Content-Type: application/json" "${url}/artifactory/api/repositories/${project}-maven-local" -d @-
sed "s/_PROJECT/${project}/g" maven-remote.json |\
  curl -u admin:${token} -X PUT -H "Content-Type: application/json" "${url}/artifactory/api/repositories/${project}-maven-remote" -d @-
sed "s/_PROJECT/${project}/g" maven.json |\
  curl -u admin:${token} -X PUT -H "Content-Type: application/json" "${url}/artifactory/api/repositories/${project}-maven" -d @-
