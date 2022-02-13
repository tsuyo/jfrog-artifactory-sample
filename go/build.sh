project=$1
build_name=$2
build_number=$3
version=$4

[ -z "${project}" -o -z "${build_name}" -o -z "${build_number}" -o -z "${version}" ] && echo "Usage: $(basename $0) <project> <build_name> <build_number> <version>" && exit 1

jfrog go build --project=${project} --build-name=${build_name} --build-number=${build_number}
jfrog gp ${version} --project=${project} --build-name=${build_name} --build-number=${build_number}
jfrog rt bce --project=${project} ${build_name} ${build_number}
jfrog rt bag --project=${project} ${build_name} ${build_number} ..
jfrog rt bp --project=${project} ${build_name} ${build_number}
