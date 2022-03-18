project=$1
build_name=$2
build_number=$3
version=$4

[ -z "${project}" -o -z "${build_name}" -o -z "${build_number}" -o -z "${version}" ] && echo "Usage: $(basename $0) <project> <build_name> <build_number> <version>" && exit 1

jf go build --project=${project} --build-name=${build_name} --build-number=${build_number}
jf gp ${version} --project=${project} --build-name=${build_name} --build-number=${build_number}
jf rt bce --project=${project} ${build_name} ${build_number}
jf rt bag --project=${project} ${build_name} ${build_number} ..
jf rt bp --project=${project} ${build_name} ${build_number}
