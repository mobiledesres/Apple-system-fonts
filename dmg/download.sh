source=sources.url

# get .dmg archives from Apple
# main page: https://developer.apple.com/fonts/
function get_fonts() {
  wget -i $source -N
}

get_fonts