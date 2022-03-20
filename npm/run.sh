project=$1
build_name=$2
build_number=$3

[ -z "${project}" -o -z "${build_name}" -o -z "${build_number}" ] && echo "Usage: $(basename $0) <project> <build_name> <build_number>" && exit 1

./clean.sh

jf npm i --project=${project} --build-name=${build_name} --build-number=${build_number}
jf npm publish --project=${project} --build-name=${build_name} --build-number=${build_number}
jf rt bce --project=${project} ${build_name} ${build_number}
jf rt bag --project=${project} ${build_name} ${build_number} ..
jf rt bp --project=${project} ${build_name} ${build_number}
