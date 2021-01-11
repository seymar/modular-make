# Finds a component and calls IncludeComponentMakefile if found
define FindComponent
comp_name := $(1)
include mk/find_component.mk
endef

# Simply expanded variables for next macro
COMPONENTS_FOUND := 
COMPONENTS_MAKEFILES_INCLUDED :=

# Includes a component Makefile and processes its variables
define IncludeComponentMakefile
$$(info $$(shell printf IncludeComponentMakefile))
comp_make := $(1)
include mk/include_component_makefile.mk
endef