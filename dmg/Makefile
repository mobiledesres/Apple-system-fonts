source := sources.url

.PHONY: all
all: get_fonts

# get .dmg archives from Apple
# main page: https://developer.apple.com/fonts/
.PHONY: get_fonts
get_fonts:
	cat $(source) | xargs -n 1 -P 4 wget -N --show-progress

.PHONY: clean
clean:
	-rm -rfv *.dmg
