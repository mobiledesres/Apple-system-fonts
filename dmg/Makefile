url_files := $(shell ls *.url)
dmg_files := $(url_files:.url=.dmg)

split_files := $(shell find -name "*.dmg??")

.PHONY: all
all: $(dmg_files) split

%.dmg: %.url
# first try: concatenate split .dmg files
	$(eval dmg_src := $(shell find -name "$@??" | sort))
	if [ -n "$(dmg_src)" ] ; then \
		cat $(dmg_src) > "$@" ; \
	fi
# second try: get .dmg archives from Apple
# main page: https://developer.apple.com/fonts/
	wget -N -i "$<"

split_size := 49000000 # do not exceed file size limit of GitHub

.PHONY: split
split: $(dmg_files)
	for dmg_file in $(dmg_files); do \
		split -b $(split_size) -d $$dmg_file $$dmg_file; \
	done

.PHONY: rmsplit
rmsplit:
	-rm -rfv $(split_files)

.PHONY: clean
clean:
	-rm -rfv $(dmg_files)
