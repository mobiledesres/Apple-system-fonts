ERROR_ARGS=1
ERROR_RW=-1

if [ $# -lt 2 ]
then
    echo "Usage: bash \"$0\" \"<path_to_dmg>\"" "\"<extract_dir>\"" >&2
    exit $ERROR_ARGS
fi

dmgFile="$1"
extractDir="$2"

# check prerequisite packages
source check_prereqs.sh

# directory utilities
source dir_utils.sh

# extract utilities
source extract_utils.sh

# extract fonts from a .dmg file
# Usage: extract_fonts "$dmgFile" "$extractDir"
function extract_fonts {
    # 1. create extract directory for fonts
    local extractDir="$2"
    make_extract_dir "$extractDir"

    # 2. create temporary directory to extract files
    local tempDir=$(make_temp_dir)

    # 3. convert .dmg to .img, and put int in temporary directory
    local dmgFile="$1"
    local dmgBaseName="$(basename "${dmgFile%.*}")"
    local imgFile="$tempDir/$dmgBaseName.img"
    extract_dmg_to_img "$dmgFile" "$imgFile"

    # 4. extract fonts from the .img file
    extract_fonts_from_img "$imgFile" "$extractDir"

    # 5. clean up temporary directory
    rm -rf "$tempDir"
}

extract_fonts "$dmgFile" "$extractDir"
