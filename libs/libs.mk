comp_include := $(comp)
comp_srcs := $(wildcard $(comp)/*.c)
comp_objs := $(comp_srcs:%.c=build/%.o)
comp_ar := $(comp_bdir)/$(comp_name).a

# Rule to make objects for archive
build/$(comp)/%.o: $(comp)/%.c
	$(Q)printf "  CC \n"
	$(Q)$(CC) $(comp_include:%=-I%) $(CFLAGS) -o $@ -c $^

# Rule to make archive
$(comp)-outputs: $(comp_ar)
$(comp_ar): $(comp_objs)
	$(Q)printf "  AR \n"
	$(Q)$(AR) $(ARFLAGS) $@ $^

