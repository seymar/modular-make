COMP_SRCS := $(wildcard $(COMP_DIR)/*.c)
COMP_OBJS := $(COMP_SRCS:%.c=$(BUILD_DIR)/%.o)
COMP_ARS := $(COMP_BDIR)/libsomelib.a

# Add the archive to the linker of the app
LINKABLES += $(COMP_ARS)

# Add the archive to the outputs of the component so it gets build
COMP_OUTPUTS := $(COMP_ARS)


# Rules to biuld outputs
$(BUILD_DIR)/%.o: %.c
	@printf "CC \n"
	$(CC) $(CFLAGS) -o $@ -c $^

$(COMP_BDIR)/libsomelib.a: $(COMP_OBJS)
	@printf "AR \n"
	$(AR) $(ARFLAGS) $@ $^
