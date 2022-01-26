list=`echo $(jfrog c s | grep "Server ID:" | awk '{print $3}') | sed "s/ /, /g"`
read -p "server id [$list]: " server_id
read -p "user: " user
read -sp "token: " token
echo ""
read -p "project: " project

url=`jfrog c s $server_id | head -2 | tail -1 | awk '{print $4}'`
url=${url::-1}

echo "create project"
curl -H "Content-Type: application/json; charset=UTF-8" -H "Authorization: Bearer ${token}" \
  -X POST "${url}/access/api/v1/projects" -d "{\"display_name\": \"${project}\", \"project_key\": \"${project}\"}"
echo ""
