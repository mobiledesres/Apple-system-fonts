dmg := dmg
dmg_files := $(shell find $(dmg)/ -name *.dmg)

fonts := fonts
fonts_dirs := $(foreach dmg_file,$(dmg_files),$(fonts)/$(basename $(notdir $(dmg_file))))

extract_exec := extract_fonts_from_dmg.sh


.PHONY: all
all: fonts

.PHONY: fonts
fonts: dmg $(fonts_dirs)
ifndef fonts_dirs
	$(MAKE) fonts
endif

$(fonts)/%: $(dmg)/%.dmg
	bash $(extract_exec) "$<" "$@"

# This target to ensure that the .dmg files are there
# Otherwise they will be re-downloaded
.PHONY: dmg
dmg:
ifndef dmg_files
	$(MAKE) -C $(dmg)/
endif

.PHONY: clean
clean:
	-rm -rfv $(fonts)/