#$(info AddComponents($(comp)))# src/hello_world

comp := $(comp:.mk=)
comp_parts := $(subst /, ,$(comp))
comp_typedir := $(firstword $(comp_parts))
comp_type := $(comp_typedir:s=)
comp_name := $(lastword $(comp_parts))
comp_mk := $(wildcard $(comp).mk)
comp_mk += $(wildcard $(comp)/$(comp_type).mk)
comp_mk += $(wildcard $(comp)/$(comp_name).mk)
comp_mk := $(firstword $(comp_mk))
comp_path := $(dir $(comp_mk))
comp_dir := $(comp_path:/=)
comp_bdir := build/$(comp_dir)

$(info $(comp) ($(comp_type)) @ $(comp_mk))

ifeq ($(comp_mk),)
$(error Could not find a makefile for $(comp))
endif

# $(info comp		$(comp))
# $(info comp_typedir	$(comp_typedir))
# $(info comp_type	$(comp_type))
# $(info comp_name	$(comp_name))
# $(info comp_mk		$(comp_mk))
# $(info comp_dir		$(comp_dir))

# Component rules
.PHONY: $(comp) $(comp)-inputs $(comp)-outputs
.NOTPARALLEL:
$(comp): $(comp_bdir) $(comp)-inputs $(comp)-outputs;
	$(info $(shell printf "  BUILD   $@"))
$(comp_bdir):; $(info $(shell printf "  MKDIR   $(comp)")) $(Q)mkdir -p $@
$(comp)-inputs:
$(comp)-outputs:
clean-$(comp):
	$(info $(shell printf "  RM      $(comp_bdir)"))
	$(Q)rm -rf $(comp_bdir)

# Initialize variables the component can set and include the component
components_temp := $(components)
components :=
dependencies :=
include $(comp_mk)

# Add dependencies as inputs so they get build first
dependencies := $(filter-out $(components_temp),$(dependencies))
$(info $(shell printf "\tdependencies\t$(dependencies)"))
$(comp)-inputs: $(dependencies)

# Initialize variables the sub-components can set
components_archives_temp := $(components_archives)
components_archives :=

# Include new components
components := $(filter-out $(dependencies) $(components_temp),$(components)) $(components_temp)
$(foreach com,$(dependencies) $(new_components),$(eval $(call AddComponent,$(com))))

