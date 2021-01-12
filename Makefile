# Config
APP = hello_world
COMPONENTS_MAKEFILES = apps/$(APP)/app.mk

# Let the app overwrite general components
COMPONENTS_DIRS := apps/$(APP)/components
# Source modules used in multiple apps
COMPONENTS_DIRS += modules
# Mostly external components such as frameworks, tools etc.
# Can even contain a full toolchain
COMPONENTS_DIRS += components
# Libraries only
COMPONENTS_DIRS += libs

include mk/components.mk