COMPONENTS_ADDED := $(COMPONENTS)

# Includes a component Makefile and processes its variables
define AddComponent
#$$(info $$(shell printf "AddComponent $(1)"))
comp := $(1)
parent := $(2)
include mk/add_component.mk
endef

$(info $(shell printf "COMPONENTS $(COMPONENTS)"))

# Include top-level component makefiles
TLCOMPONENTS := $(foreach mk,$(COMPONENTS),$(mk) \
	$(eval $(call AddComponent,$(mk),)))

$(info $(shell printf "TLCOMPONENTS $(TLCOMPONENTS)"))

#$(info $(shell printf "apps/hello_world-children\t$(apps/hello_world-children)"))

$(info $(shell printf "COMPONENTS_ADDED $(COMPONENTS_ADDED)"))
$(info $(shell printf "\t-children $(value -children)"))

GOALS := $(TLCOMPONENTS:%=build-%)

$(info $(shell printf "GOALS: $(GOALS)"))

.DEFAULT_GOAL := all
all: $(GOALS) | $(BUILD_DIR)

$(BUILD_DIR):
	mkdir -p $@
