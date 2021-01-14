
BINARIES := $(BINARIES:%=bin/%)
.DEFAULT_GOAL := all
all: $(BINARIES)

BUILD_DIR = build

test-sources = some.c
test-objects = some.o

someapp-linkables = $(BUILD_DIR)/test.a

hello_world-linkables = $(BUILD_DIR)/test.a

$(BUILD_DIR)/%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $^

.SECONDEXPANSION:
$(BUILD_DIR)/%.a: $$(%-objects)
	$(AR) $(ARFLAGS) $@ $^

LDFLAGS = -arch x86_64 -macosx_version_min 10.10.0 -dylib

# Link - LINKABLES variable is built up by the components include
.SECONDEXPANSION:
bin/%: $$(%-linkables)
	$(LD) $^ $(LDFLAGS) -o $@