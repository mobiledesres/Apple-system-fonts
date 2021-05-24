dmg_dir := dmg
url_files := $(shell ls $(dmg_dir)/*.url)
dmg_files := $(url_files:.url=.dmg)

fonts_root_dir := fonts
fonts_dirs := $(patsubst $(dmg_dir)/%.url,$(fonts_root_dir)/%,$(url_files))
fonts_zip := fonts.zip

extract_exec := extract-fonts.sh

.PHONY: all
all: fonts

# extract fonts from .dmg
.PHONY: fonts
fonts: $(dmg_files) $(fonts_dirs)

# get each .dmg file
$(dmg_dir)/%.dmg:
	$(MAKE) -C "$(dir $@)" "$(notdir $@)"

# extract fonts from each .dmg into a directory
$(fonts_root_dir)/%: $(dmg_dir)/%.dmg
	bash $(extract_exec) "$<" "$@"

# pack all fonts into a .zip file
.PHONY: zip
zip: $(fonts_zip)

$(fonts_zip): fonts
	zip -r "$@" "$<"

.PHONY: rmzip
rmzip:
	-rm -rfv $(fonts_zip)

.PHONY: clean
clean: rmzip
	-rm -rfv $(fonts_root_dir)/