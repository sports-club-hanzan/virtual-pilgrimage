function decode() { echo "${*}" | base64 --decode; }

IFS=',' read -r -a define_items <<< "$DART_DEFINES"


for index in "${!define_items[@]}"
do
    define_items[$index]=$(decode "${define_items[$index]}");
done

printf "%s\n" "${define_items[@]}" | grep -v "flutter" > ${SRCROOT}/Flutter/EnvironmentVariables.xcconfig
