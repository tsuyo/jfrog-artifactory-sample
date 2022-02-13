project=$1
build_name=$2
build_number=$3
reg_srv=$4
reg_name=$5
img_name=$6
version=$7

[ -z "${project}" -o -z "${build_name}" -o -z "${build_number}" -o -z "${reg_srv}" -o -z "${reg_name}" -o -z "${img_name}" -o -z "${version}" ] && echo "Usage: $(basename $0) <project> <build_name> <build_number> <reg_srv> <reg_name> <img_name> <version>" && exit 1

docker login ${reg_srv}
docker build --no-cache --build-arg REG=${reg_srv}/${reg_name} -t ${reg_srv}/${reg_name}/${img_name}:${version} .
jfrog rt dp ${reg_srv}/${reg_name}/${img_name}:${version} ${reg_name} --project=${project} --build-name=${build_name} --build-number=${build_number}
jfrog rt bce --project=${project} ${build_name} ${build_number}
jfrog rt bag --project=${project} ${build_name} ${build_number} ..
jfrog rt bp --project=${project} ${build_name} ${build_number}
