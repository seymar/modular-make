$(info $(lastword $(MAKEFILE_LIST)))

# Components to build in parallel to this component
# Adds their public include paths to compilation of this component
COMPONENTS := postgresql a

SUBMODULES :=
