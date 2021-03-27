source := sources.url

.PHONY: all
all: get_fonts

# get .dmg archives from Apple
# main page: https://developer.apple.com/fonts/
.PHONY: get_fonts
get_fonts:
	wget -i $(source) -N

.PHONY: clean
clean:
	-rm -rfv *.dmg