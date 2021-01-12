#* Asterisk = only to verify inputs because of user errors

# Reset the variables set by the component.mk to prevent issues
COMPONENTS := 
DEPENDENCIES := 
include $(comp_make)
COMPONENTS_MAKEFILES_INCLUDED += $(mk)

COMPONENTS_ADDED += $(COMPONENTS)

# Add components and dependencies their public include paths to the compiler
# Add source directories COMPONENT_SRCDIRS
# Add sources COMPONENT_SRCS
# Set COMPONENT_INCLUDES_PRIVATE compilation
# Set public include paths variable for dependents

$(info $(shell printf "\tCOMPONENTS\t$(COMPONENTS)"))
$(info $(shell printf "\tDEPENDENCIES\t$(DEPENDENCIES)"))

#* Exclude components that are in dependencies to prevent duplicates O(n^2)?
COMPONENTS_TO_FIND := $(filter-out $(DEPENDENCIES),$(COMPONENTS_ADDED)) $(DEPENDENCIES)

# Exclude components already found before to prevent them being searched for
COMPONENTS_TO_FIND := $(filter-out $(COMPONENTS_FOUND),$(COMPONENTS_TO_FIND))

$(info $(shell printf "\tCOMPONENTS_TO_FIND $(COMPONENTS_TO_FIND)"))

# Find new components and dependencies
NEW_MKS := \
$(strip $(foreach comp,$(COMPONENTS_TO_FIND), \
	$(firstword $(foreach cdir,$(COMPONENTS_DIRS), \
		$(wildcard $(cdir)/$(comp)/component.mk) \
	)) \
))
$(info $(shell printf "\tNEWMKS $(NEW_MKS)"))
$(foreach mk,$(NEW_MKS),$(eval $(call IncludeComponentMakefile,$(mk))))

