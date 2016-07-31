# -*-makefile-*-
#
# Copyright (C) 2016 by Roland Hieber <rohieb@rohieb.name>
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_DTNDHT) += dtndht

#
# Paths and names
#
DTNDHT_VERSION := 0.2.3
DTNDHT_MD5     := 37c33910ac7e760aad4db81724aeb4fb
DTNDHT         := dtndht-$(DTNDHT_VERSION)
DTNDHT_SUFFIX  := tar.gz
DTNDHT_URL     := https://www.ibr.cs.tu-bs.de/projects/ibr-dtn/releases/$(DTNDHT).$(DTNDHT_SUFFIX)
DTNDHT_SOURCE  := $(SRCDIR)/$(DTNDHT).$(DTNDHT_SUFFIX)
DTNDHT_DIR     := $(BUILDDIR)/$(DTNDHT)
DTNDHT_LICENSE := MIT

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
DTNDHT_CONF_TOOL := autoconf
DTNDHT_CONF_OPT  := $(CROSS_AUTOCONF_USR) \
	--$(call ptx/wwo, PTXCONF_DTNDHT_WITH_OPENSSL)-openssl \

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/dtndht.targetinstall:
	@$(call targetinfo)

	@$(call install_init,   dtndht)
	@$(call install_fixup,  dtndht,PRIORITY,optional)
	@$(call install_fixup,  dtndht,SECTION,base)
	@$(call install_fixup,  dtndht,AUTHOR,"Roland Hieber <rohieb@rohieb.name>")
	@$(call install_fixup,  dtndht,DESCRIPTION,missing)

	@$(call install_lib,    dtndht, 0, 0, 0755, libdtndht-0.2)

	@$(call install_finish, dtndht)

	@$(call touch)

# vim: syntax=make
