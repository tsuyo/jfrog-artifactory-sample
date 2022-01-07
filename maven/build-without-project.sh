build_name=$1
build_number=$2

[ -z "${build_name}" -o -z "${build_number}" ] && echo "Usage: ${FUNCNAME[0]} <build_name> <build_number>" && exit 1

jfrog mvn clean deploy --build-name=${build_name} --build-number=${build_number}
jfrog rt bce ${build_name} ${build_number}
jfrog rt bag ${build_name} ${build_number} ..
jfrog rt bp ${build_name} ${build_number}
