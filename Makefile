MAKEFLAGS += --no-builtin-rules
.SUFFIXES:

components := src/hello_world
binaries := $(components:src/%=bin/%)

include mk/components.mk

build: $(components)
clean: $(components:%=clean-%)
