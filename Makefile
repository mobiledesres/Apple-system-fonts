dmg := dmg
dmg_files := $(shell find $(dmg)/ -name *.dmg)

fonts := fonts


.PHONY: all
all: dmg

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