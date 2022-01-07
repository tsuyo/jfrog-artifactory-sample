project=$1
build_name=$2
build_number=$3

[ -z "${project}" -o -z "${build_name}" -o -z "${build_number}" ] && echo "Usage: ${FUNCNAME[0]} <project> <build_name> <build_number>" && exit 1

jfrog mvn clean deploy --project=${project} --build-name=${build_name} --build-number=${build_number}
jfrog rt bce --project=${project} ${build_name} ${build_number}
jfrog rt bag --project=${project} ${build_name} ${build_number} ..
jfrog rt bp --project=${project} ${build_name} ${build_number}
