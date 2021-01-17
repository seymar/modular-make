$(info $(lastword $(MAKEFILE_LIST)))

VER := 13.1
NAME := postgresql-$(VER)
GZURL := https://ftp.postgresql.org/pub/source/v$(VER)/$(NAME).tar.gz

DOWNLOADS := $(GZURL)

# The essence of a component.mk is:
# - Can add source files to the parent directly PRIVATE_INCLUDES
# - Can add include paths to the parent PUBLIC_INCLUDES
# - Can add a static library (.a) to the top-level linker
# - Static libraries can be build by the main Makefile or with a custom target
postgresql-build: $(NAME)
$(NAME):
	wget $(GZURL)
	tar -xf $(name).tar.gz

