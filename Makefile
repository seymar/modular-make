# Config
APPS = hello_world someapp

COMPONENTS := $(APPS:%=apps/%)

COMPONENTS_DIRS += components
COMPONENTS_DIRS += libs

BUILD_DIR := build

include mk/components.mk



# Targets:
# clean-<type>
# TYPE implicitly set per component based on the name of its makefile
# i.e. "component" "app" "lib" "module"

# Types
# All components have a type, which is derived from the name of its makefile
# It allows filtering of components with make targets:
# build-libs build-components clean-libs
# Example types:
# module:    project code, no externals, lots of rebuilds, directly linked objects
# lib:       libraries, external code, zero rebuilds, archived into .a for later use
# component: can be anything, tools
# It allows setting of default values for component makefiles variables in a
# makefile in the searchdirectory with name <type>s.mk