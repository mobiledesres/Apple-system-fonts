dmg := dmg
dmg_files := $(shell find $(dmg)/ -name *.dmg)

fonts := fonts
fonts_dirs := $(foreach dmg_file,$(dmg_files),$(fonts)/$(basename $(notdir $(dmg_file))))

zip := fonts.zip

extract_exec := extract-fonts.sh


.PHONY: all
all: fonts

# extract fonts from .dmg
.PHONY: fonts
fonts: dmg $(fonts_dirs)
ifndef fonts_dirs
	$(MAKE) fonts
endif

# fonts from each .dmg is extracted into a directory
$(fonts)/%: $(dmg)/%.dmg
	bash $(extract_exec) "$<" "$@"

# This target is used to ensure that the .dmg files are there
# Otherwise they will be re-downloaded
.PHONY: dmg
dmg:
ifndef dmg_files
	$(MAKE) -C $(dmg)/
endif

# pack all fonts into a .zip file
.PHONY: zip
zip: $(zip)

$(zip): fonts
	zip -r "$@" "$<"

.PHONY: rmzip
rmzip:
	-rm -rfv $(zip)

.PHONY: clean
clean:
	-rm -rfv $(fonts)/