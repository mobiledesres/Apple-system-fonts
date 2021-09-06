function extract_dmg_to_img {
    local dmgFile="$1"
    local imgFile="$2"
    dmg2img "$dmgFile" "$imgFile"
}

function extract_img {
    local imgFile="$1"
    local extractDir="$2"
    7z x "$imgFile" -O"$extractDir"
}