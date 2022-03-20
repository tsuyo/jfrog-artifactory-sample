error_message() {
    list=`echo $(jf c s | grep "Server ID:" | awk '{print $3}') | sed "s/ /, /g"`
    echo "Usage: $0 -s <server_id> ($list) -r <repo_name> <project> <build_name> <build_number>"
    exit 0
}

OPTIND=1 # Reset in case getopts has been used previously in the shell.

server_id=""

while getopts "h?s:r:" opt; do
    case "$opt" in
    h|\?)
        error_message
        ;;
    s)  server_id=$OPTARG
        ;;
    r)  repo_name=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

project=$1
build_name=$2
build_number=$3

if [ "$server_id" == "" ] || [ "$repo_name" == "" ] || [ "$project" == "" ] || [ "$build_name" == "" ] || [ "$build_number" == "" ]; then
  error_message
fi

url=`jf c s $server_id | head -2 | tail -1 | awk '{print $4}'`
url=${url::-1}

repository_url="${url}/artifactory/api/pypi/${project}-${repo_name}"

echo "run with [server_id: ${server_id}, repo_name: ${repo_name}, project: ${project}, build_name: ${build_name}, build_number: ${build_number}]"

# Preparation
python3 -m venv venv
. venv/bin/activate
python3 -m pip install --upgrade pip

# Resolve dependencies
jf pip install Babel --project=${project} --build-name=${build_name} --build-number=${build_number}--no-cache-dir --force-reinstall

# Build
python3 -m pip install --upgrade setuptools wheel
python3 setup.py sdist bdist_wheel

# Publish
python3 -m pip install --upgrade twine
python3 -m twine upload --repository-url ${repository_url} dist/*

jf rt bce --project=${project} ${build_name} ${build_number}
jf rt bag --project=${project} ${build_name} ${build_number} ..
jf rt bp --project=${project} ${build_name} ${build_number}

# Clean up
deactivate
