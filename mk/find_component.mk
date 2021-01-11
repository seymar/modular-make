$(foreach cdir,$(COMPONENTS_DIRS),
	$(firstword $(wildcard $(cdir)/$(comp_name)/component.mk))
)

# Search for components
COMPONENTS_MAKEFILES_FOUND := 


COMPONENTS_TEMP += $(COMPONENTS_FOUND)
COMPONENTS := $(COMPONENTS_TEMP)