dmg := dmg
dmg_files := $(shell find $(dmg)/ -name *.dmg)

img := img
img_files := $(foreach dmg_file,$(dmg_files),$(img)/$(basename $(notdir $(dmg_file))).img)


.PHONY: all
all: $(img)


.PHONY: img
img: dmg $(img_files)
ifndef img_files
	$(MAKE) img
endif

# This target to ensure that the .dmg files are there
# Otherwise they will be re-downloaded
.PHONY: dmg
dmg:
	$(MAKE) -C $(dmg)/

# Convert .dmg files to .img files
$(img)/%.img: $(dmg)/%.dmg
	@mkdir -p $(img)
	dmg2img $< $@


.PHONY: clean
clean:
	-rm -rfv $(img)/