comp_srcs := $(wildcard $(comp)/*.c)
comp_srcs += $(wildcard $(comp)/*.cpp)

comp_include := $(comp)

comp_bin := bin/$(comp_name)

# Rule to create binary for the source subdirectory
$(comp)-outputs: $(comp_bin)
$(comp_bin): $(comp_srcs) $(components_archives)
	$(Q)printf "  BIN     $@ < $^\n"
	$(CC) $(comp_include:%=-I%) $(archives) $^ -o $@

# Add clean target
clean-$(comp): cleanbin-$(comp)
cleanbin-$(comp): bintorm := $(comp_bin)
cleanbin-$(comp):
	$(Q)printf "  RM      $(bintorm)\n"
	$(Q)rm -f $(bintorm)
