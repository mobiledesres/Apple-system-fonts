ERROR_PREREQ=2

# check whether a package for the executable is installed
# Usage: check_exec <exec> [package]
function check_exec {
    local exec="$1"
    local package="$2"
    if [[ -z $package ]]; then
        package="$1"
    fi

    # check executable
    "$exec" > /dev/null
    local ret=$?
    if [ $ret -ne 0 ]; then
        echo "ERROR: package \"$package\" is not installed." >&2
    fi
    return $ret
}

# check prerequisite packages: dmg2img and p7zip-full
function check_prereqs {
    local check=0

    check_exec dmg2img
    check=$(expr $check \| $?)

    check_exec 7z p7zip-full
    check=$(expr $check \| $?)

    if [[ $check -ne 0 ]]; then
        echo "Prerequisite check failed." >&2
        exit $ERROR_PREREQ
    fi
}

check_prereqs