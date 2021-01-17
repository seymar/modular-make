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

$(info $(shell printf "\e[97m$(comp) (\e[34m$(comp_type)\e[97m) \e[31m@\e[39m \e[97m$(comp_mk)\e[0m\n"))

ifeq ($(comp_mk),)
$(error Could not find a makefile for $(comp))
endif

# Component rules
.PHONY: $(comp) inputs-$(comp) outputs-$(comp)
.NOTPARALLEL:
$(comp): $(comp_bdir) inputs-$(comp) outputs-$(comp)
	$(info $(shell printf "  BUILD   $@"))
$(comp_bdir):; $(info $(shell printf "  MKDIR   $@")) $(Q)mkdir -p $@
inputs-$(comp):
outputs-$(comp):
clean-$(comp):
	$(Q)printf "  RM      $(cleanables)\n"
	$(Q)rm -rf $(cleanables)

# Initialize variables the component can set and include the component
components_temp := $(components)
components :=
dependencies :=
comp_outputs :=
comp_cleanables = $(comp_bdir)
include $(comp_mk)

# Set target specific variables
clean-$(comp): cleanables := $(comp_cleanables)

# Add variables to targets
outputs-$(comp): $(comp_outputs)
$(comp)_outputs = $(comp_outputs)

# Add dependencies as inputs so they get build first
inputs-$(comp): $(dependencies)
$(info $(shell printf "\tdependencies\t$(dependencies)"))

# Include new components
new_components := $(filter-out $(components_temp),$(dependencies) $(components))
components := $(components_temp) $(new_components)
$(info $(shell printf "\tnew_components\t$(new_components)"))
$(foreach com,$(new_components),$(eval $(call AddComponent,$(com))))
