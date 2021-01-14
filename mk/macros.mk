# Finds a component and calls IncludeComponentMakefile if found
define FindComponent
comp_name := $(1)
include mk/find_component.mk
endef

# Simply expanded variables for next macro
COMPONENTS_FOUND := 
COMPONENTS_MAKEFILES_INCLUDED :=
