list=`echo $(jfrog c s | grep "Server ID:" | awk '{print $3}') | sed "s/ /, /g"`
read -p "server id [$list]: " server_id
read -p "prefix: " prefix

url=`jfrog c s $server_id | head -2 | tail -1 | awk '{print $4}'`
url=${url::-1}

echo "delete repos"
jfrog rt rdel --quiet ${prefix}-maven
jfrog rt rdel --quiet ${prefix}-maven-local
jfrog rt rdel --quiet ${prefix}-maven-remote
