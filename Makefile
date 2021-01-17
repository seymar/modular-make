#!/usr/bin/make -j
MAKEFLAGS += --no-builtin-rules
.SUFFIXES:
Q ?= @
.DEFAULT_GOAL := build

components := src/hello_world

include mk/flags.mk
include mk/components.mk

build: build-components
clean: clean-components
