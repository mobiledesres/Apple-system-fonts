url_files := $(shell ls *.url)
dmg_files := $(url_files:.url=.dmg)

.PHONY: all
all: $(dmg_files)

# get .dmg archives from Apple
# main page: https://developer.apple.com/fonts/
%.dmg: %.url
	wget -N -i "$<"

.PHONY: clean
clean:
	-rm -rfv $(dmg_files)
