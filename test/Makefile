VALS := a_

include a.mk

.PHONY: somerule
.SECONDEXPANSION:
somerule: $$(VALS)
	echo $(VALS) > somerule

VALS := $(VALS:_=) b
