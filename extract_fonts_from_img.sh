img_file="$1"

if [ "$img_file" == "" ]
then
  echo "Usage: bash $0 <.img_file_to_extract>"
  exit 1
fi

fonts_dir="fonts"
ext=".img"

function extract_fonts_from_img {
  # 1. create target directory for fonts
  local target_dir="$fonts_dir/$(basename -s $ext ""$1"")"
  mkdir -pv "$target_dir"

  # 2. create temporary directory to extract files
  local tempdir=$(mktemp -d)

  # 3. extract .img to temporary directory
  7z x "$img_file" -O"$tempdir"

  # 4. change to temporary directory
  # extract the .pkg file there
  pushd "$tempdir"
  find . -name *.pkg -exec 7z x {} ";"

  # 5. extract Payload~
  local payload="Payload~"
  find . -name "$payload" -exec 7z x {} ";"

  # 6. go back to current directory
  # move all .otf and .ttf files to target directory
  popd
  find "$tempdir" -name "*.[ot]tf" -exec mv {} "$target_dir" ";"

  # 7. clean up temporary directory
  rm -rf "$tempdir"
}

extract_fonts_from_img "$img_file"