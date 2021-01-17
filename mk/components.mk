# Includes a component Makefile and processes its variables
define AddComponent
comp := $(1)
dependenent := $(2)
include mk/add_component.mk
endef

$(info components	$(components))

# Global variables to which the components can add 

$(foreach c,$(components),$(eval $(call AddComponent,$(c))))

.DEFAULT_GOAL := all
all: build
build:
	mkdir -p $@
