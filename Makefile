# Config
APP = hello_world
COMPONENTS_MAKEFILES = apps/$(APP)/app.mk
COMPONENTS_DIRS = apps/$(APP)/components components

include mk/macros.mk

$(info $(shell printf "COMPONENTS_MAKEFILES\t\t$(COMPONENTS_MAKEFILES)"))

# Include top-level component makefiles
$(foreach mk,$(COMPONENTS_MAKEFILES),$(eval $(call IncludeComponentMakefile,$(mk))))

$(info $(shell printf "COMPONENTS_MAKEFILES_INCLUDED\t$(COMPONENTS_MAKEFILES_INCLUDED)"))
# $(info $(shell printf "COMPONENTS $(COMPONENTS)"))

#all: $(ALL_PREREQS)


.DEFAULT_GOAL := all