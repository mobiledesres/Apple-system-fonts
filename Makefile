dmg := dmg
dmg_files := $(shell find $(dmg)/ -name *.dmg)

img := img
img_files := $(foreach dmg_file,$(dmg_files),$(img)/$(basename $(notdir $(dmg_file))).img)

.PHONY: all
all: $(img)

.PHONY: img
img: $(img_files)

img/%.img: dmg/%.dmg
	@mkdir -p $(img)
	dmg2img $< $@

.PHONY: clean
clean:
	-rm -rfv $(img)/