# Includes a component Makefile and processes its variables
define AddComponent
comp := $(1)
dependenent := $(2)
include mk/add_component.mk
endef

$(foreach c,$(components),$(eval $(call AddComponent,$(c))))

$(info ========================================================================)

build-components: $(components)
clean-components: $(components:%=clean-%)
