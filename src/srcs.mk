comp_srcs := $(wildcard $(comp)/*.c)
comp_srcs += $(wildcard $(comp)/*.cpp)

comp_include := $(comp)

comp_bin := bin/$(comp_name)
comp_outputs := $(comp_bin)
comp_cleanables += $(comp_bin)

# Rule to create binary for the source subdirectory
$(comp_bin): arvars := $(dependencies:=_outputs)
$(comp_bin): $(comp_srcs)
	$(Q)printf "  BIN     $@\n"
	$(Q)$(CC) $(comp_include:%=-I%) $^ $(foreach av,$(arvars),$($(av))) -o $@
