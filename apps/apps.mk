# Set the inputs of the app to all the build targets of its children
$(eval $(COMP_DIR)-inputs = $$($(COMP_DIR)-children:%=build-%))
$(eval $(COMP_DIR)-outputs = $$($(COMP_DIR)-children:%=build-%))

# Build the executable from the outputs of the children
$(COMP_BDIR)/%.out:
	@printf "LD $@ < $^\n"
	$(LD) $^ $(LDFLAGS) -o $@
