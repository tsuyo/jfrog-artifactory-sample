error_message() {
    list=`echo $(jfrog c s | grep "Server ID:" | awk '{print $3}') | sed "s/ /, /g"`
    echo "Usage: $0 -s <server_id> ($list) [-p] [-t <token>] <project>"
    exit 0
}

OPTIND=1 # Reset in case getopts has been used previously in the shell.

prompt=0
server_id=""
token=""

while getopts "h?ps:t:" opt; do
    case "$opt" in
    h|\?)
        error_message
        ;;
    p)  prompt=1
        ;;
    s)  server_id=$OPTARG
        ;;
    t)  token=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

project=$1

if [ $prompt -eq 1 ]; then
    read -sp "artifactory token: " token
    echo ""
fi

if [ "$server_id" == "" ] || [ "$token" == "" ] || [ "$project" == "" ]; then
  error_message
fi

url=`jfrog c s $server_id | head -2 | tail -1 | awk '{print $4}'`
url=${url::-1}

echo "delete project"
curl -H "Authorization: Bearer ${token}" -X DELETE "${url}/access/api/v1/projects/${project}"

echo "delete build-info repo"
jfrog rt rdel --quiet ${project}-build-info
