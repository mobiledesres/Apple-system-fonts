function make_extract_dir {
    local extractDir="$1"
    mkdir -pv "$extractDir"
    if [ $? -ne 0 ]; then
        echo "ERROR: unable to create extract directory at \"$extractDir\"" >&2
        exit $ERROR_RW
    fi
}

# Note: use tempDir=$(make_temp_dir) to save the temporary directory
function make_temp_dir {
    local tempDir="$(mktemp -d)"
    if [ $? -ne 0 ]; then
        echo "ERROR: unable to create temporary directory at \"$tempDir\"" >&2
        exit $ERROR_RW
    fi
    echo $tempDir
}