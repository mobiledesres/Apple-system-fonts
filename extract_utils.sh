source dir_utils.sh

function extract_dmg_to_img {
    local dmgFile="$1"
    local imgFile="$2"
    dmg2img "$dmgFile" "$imgFile"
}

function extract_fonts_from_img {
    local imgFile="$1"
    local extractDir="$2"

    # 1. extract .img to temporary directory
    local tempDir=$(make_temp_dir)
    7z x "$imgFile" -O"$tempDir"

    # 2. extract the .pkg file in the temporary directory
    find "$tempDir" -name "*.pkg" -exec 7z x -O"$tempDir" {} ";"

    # 3. extract the "Payload~" file
    find "$tempDir" -name "Payload~" -exec 7z x -O"$tempDir" {} ";"

    # 4. move all .otf and .ttf files to target directory
    find "$tempDir" -name "*.[ot]tf" -exec mv -v {} "$extractDir" ";"
}