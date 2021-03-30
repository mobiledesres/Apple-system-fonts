if [ $# -lt 2 ]
then
  echo "Usage: bash $0 \"<.dmg_file_to_extract>\"" "<extract_directory>"
  exit 1
fi

dmg_file="$1"
extract_dir="$2"

# extract fonts from a .dmg file
# Usage: extract_fonts_from_dmg "$dmg_file" "$extract_dir"
function extract_fonts_from_dmg {
  # 1. create target directory for fonts
  local extract_dir="$2"
  mkdir -pv "$extract_dir"

  # 2. create temporary directory to extract files
  local tempdir="$(mktemp -d)"

  # 3. convert .dmg to .img, and put int in temporary directory
  local dmg_file="$1"
  local basename="$(basename ""${dmg_file.%}"")"
  local img_file="$tempdir/$basename.img"
  dmg2img -i "$dmg_file" -o "$img_file"

  # 4. extract .img to temporary directory
  7z x "$img_file" -O"$tempdir"

  # 5. extract the .pkg file in the temporary directory
  find "$tempdir" -name "*.pkg" -exec 7z x -O"$tempdir" {} ";"

  # 6. extract the "Payload~" file
  local payload="Payload~"
  find "$tempdir" -name "$payload" -exec 7z x -O"$tempdir" {} ";"

  # 7. go back to current directory
  # move all .otf and .ttf files to target directory
  find "$tempdir" -name "*.[ot]tf" -exec mv -v {} "$extract_dir" ";"

  # 8. clean up temporary directory
  rm -rf "$tempdir"
}

extract_fonts_from_dmg "$dmg_file" "$extract_dir"