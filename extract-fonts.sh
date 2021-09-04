if [ $# -lt 2 ]
then
  echo "Usage: bash \"$0\" \"path/to/dmg.dmg\"" "\"extract/dir\"" >&2
  exit 1
fi

dmgFile="$1"
extractDir="$2"

# check if both dmg2img and p7zip-full are installed
function check_utils {
  local check=0

  # check dmg2img
  dmg2img
  check=$(expr $check \| $?)
  if [ $check -ne 0 ]; then
    echo "ERROR: package \"dmg2img\" is not installed." >&2
  fi

  # check 7z
  7z
  check=$(expr $check \| $?)
  if [ $check -ne 0 ]; then
    echo "ERROR: package \"p7zip-full\" is not installed." >&2
  fi

  if [ $check -ne 0 ]; then
    echo "Exiting." >&2
    exit 1
  fi
}

check_utils

# extract fonts from a .dmg file
# Usage: extract_fonts "$dmgFile" "$extractDir"
function extract_fonts {
  # 1. create target directory for fonts
  local extractDir="$2"
  mkdir -pv "$extractDir"

  # 2. create temporary directory to extract files
  local tempDir="$(mktemp -d)"

  # 3. convert .dmg to .img, and put int in temporary directory
  local dmgFile="$1"
  local dmgBaseName="$(basename ""${dmgFile.%}"")"
  local imgFile="$tempDir/$dmgBaseName.img"
  dmg2img -i "$dmgFile" -o "$imgFile"

  # 4. extract .img to temporary directory
  7z x "$imgFile" -O"$tempDir"

  # 5. extract the .pkg file in the temporary directory
  find "$tempDir" -name "*.pkg" -exec 7z x -O"$tempDir" {} ";"

  # 6. extract the "Payload~" file
  find "$tempDir" -name "Payload~" -exec 7z x -O"$tempDir" {} ";"

  # 7. move all .otf and .ttf files to target directory
  find "$tempDir" -name "*.[ot]tf" -exec mv -v {} "$extractDir" ";"

  # 8. clean up temporary directory
  rm -rf "$tempDir"
}

extract_fonts "$dmgFile" "$extractDir"
