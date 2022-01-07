list=`echo $(jfrog c s | grep "Server ID:" | awk '{print $3}') | sed "s/ /, /g"`
read -p "server id [$list]: " server_id
read -sp "token: " token
echo ""
read -p "project: " project

url=`jfrog c s $server_id | head -2 | tail -1 | awk '{print $4}'`
url=${url::-1}

echo "delete repos"
jfrog rt rdel --quiet ${project}-maven
jfrog rt rdel --quiet ${project}-maven-local
jfrog rt rdel --quiet ${project}-maven-remote

echo "delete project"
curl -H "Authorization: Bearer ${token}" -X DELETE "${url}/access/api/v1/projects/${project}"

echo "delete build-info repo"
jfrog rt rdel --quiet ${project}-build-info
