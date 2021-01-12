include mk/macros.mk

#$(info $(shell printf "COMPONENTS_MAKEFILES\t\t$(COMPONENTS_MAKEFILES)"))

# Include top-level component makefiles
$(foreach mk,$(COMPONENTS_MAKEFILES),$(eval $(call IncludeComponentMakefile,$(mk))))

#$(info $(shell printf "COMPONENTS_MAKEFILES_INCLUDED\t$(COMPONENTS_MAKEFILES_INCLUDED)"))
$(info $(shell printf "COMPONENTS $(COMPONENTS_ADDED)"))

.DEFAULT_GOAL := all
#all: $(ALL_PREREQS)