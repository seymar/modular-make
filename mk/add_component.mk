# Reset the variables set by the component.mk to prevent issues
COMPONENTS := 
COMP_INPUTS :=
COMP_OUTPUTS :=

# If the component is a path to a folder, find a makefile in that folder
ifneq ($(comp:%.mk=),)
comp := $(wildcard $(comp)/*.mk)
endif

# Set variable to component directory for use in the component makefile
COMP_DIR := $(patsubst %/,%,$(dir $(comp)))
COMP_BDIR := $(BUILD_DIR)/$(COMP_DIR)

# Include the  component
$(info $(parent) -> $(COMP_DIR))
include $(comp)

$(info $(shell printf "\tCOMPONENTS\t$(COMPONENTS)"))
# $(info $(shell printf "\tDEPENDENCIES\t$(DEPENDENCIES)"))

$(eval $(COMP_DIR)-inputs += $(COMP_INPUTS))
$(eval $(COMP_DIR)-outputs += $(COMP_OUTPUTS))

$(info $(shell printf "OUTPUTS\t$(COMP_OUTPUTS)"))

# Create rule for component
define ComponentRule
.SECONDEXPANSION:
.NOTPARALLEL:
build-$(1): $(BUILD_DIR)/$(1) $$$$($(1)-inputs) $$$$($(1)-outputs)
	$$(info $$@: $$^)
	@printf "\tinputs $$($(1)-inputs)\n"
	@printf "\toutputs $$($(1)-outputs)\n"
endef
$(eval $(call ComponentRule,$(COMP_DIR)))

$(COMP_BDIR):
	mkdir -p $@

COMPONENTS_TO_ADD := $(filter-out $(COMPONENTS_ADDED),$(COMPONENTS))
COMPONENTS_ADDED += $(COMPONENTS_TO_ADD)

$(info $(shell printf "\tCOMPONENTS_TO_ADD\t$(COMPONENTS_TO_ADD)"))

# Add this component and its children to its parent (recursively)
$(eval $(COMP_DIR)-children = $(COMPONENTS))
#$(info $(COMP_DIR)-children = $(value $(COMP_DIR)-children))
$(eval $(parent)-children += $(COMP_DIR) $($(COMP_DIR)-children))
#$(info $(parent)-children += $(COMP_DIR) $($(COMP_DIR)-children))
#$(info $(parent)-children = $(value $(parent)-children))

$(foreach mk,$(COMPONENTS_TO_ADD),$(eval $(call AddComponent,$(mk),$(COMP_DIR))))

# a -> c
# a -> b -> c

# a-children: b c
# b-children: c*
# c-children:

# a-children = c-children + b-children