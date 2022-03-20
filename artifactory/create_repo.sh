error_message() {
    list=`echo $(jf c s | grep "Server ID:" | awk '{print $3}') | sed "s/ /, /g"`
    echo "Usage: $0 -s <server_id> ($list) [-u <user>] [-p] [-t <token_or_password>] <project> <repo_name> <repo_conf_dir>"
    exit 0
}

OPTIND=1 # Reset in case getopts has been used previously in the shell.

prompt=0
server_id=""
user="admin"
token=""

while getopts "h?ps:u:t:" opt; do
    case "$opt" in
    h|\?)
        error_message
        ;;
    p)  prompt=1
        ;;
    s)  server_id=$OPTARG
        ;;
    u)  user=$OPTARG
        ;;
    t)  token=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

project=$1
repo_name=$2
repo_conf_dir=$3

if [ $prompt -eq 1 ]; then
    read -sp "artifactory password or token for user <$user>: " token
    echo ""
fi

if [ "$server_id" == "" ] || [ "$token" == "" ] || [ "$project" == "" ] || [ "$repo_name" == "" ] || [ "$repo_conf_dir" == "" ]; then
  error_message
fi

url=`jf c s $server_id | head -2 | tail -1 | awk '{print $4}'`
url=${url::-1}

echo "create repos (user: ${user}, server_id: ${server_id}, project: ${project}, repo_name: ${repo_name}, repo_conf_dir: ${repo_conf_dir})"

sed "s/_PROJECT/${project}/g" ${repo_conf_dir}/${repo_name}-local.json |\
  curl -u ${user}:${token} -X PUT -H "Content-Type: application/json" "${url}/artifactory/api/repositories/${project}-${repo_name}-local" -d @-
sed "s/_PROJECT/${project}/g" ${repo_conf_dir}/${repo_name}-remote.json |\
  curl -u ${user}:${token} -X PUT -H "Content-Type: application/json" "${url}/artifactory/api/repositories/${project}-${repo_name}-remote" -d @-
sed "s/_PROJECT/${project}/g" ${repo_conf_dir}/${repo_name}.json |\
  curl -u ${user}:${token} -X PUT -H "Content-Type: application/json" "${url}/artifactory/api/repositories/${project}-${repo_name}" -d @-
