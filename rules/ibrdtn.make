# -*-makefile-*-
#
# Copyright (C) 2016 by Roland Hieber <rohieb@rohieb.name>
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IBRDTN) += ibrdtn

#
# Paths and names
#
IBRDTN_VERSION := 1.0.1
IBRDTN_MD5     := 37208be202f199f1790983ff78b2fa8f
IBRDTN         := ibrdtn-$(IBRDTN_VERSION)
IBRDTN_SUFFIX  := tar.gz
IBRDTN_URL     := https://www.ibr.cs.tu-bs.de/projects/ibr-dtn/releases/$(IBRDTN).$(IBRDTN_SUFFIX)
IBRDTN_SOURCE  := $(SRCDIR)/$(IBRDTN).$(IBRDTN_SUFFIX)
IBRDTN_DIR     := $(BUILDDIR)/$(IBRDTN)
IBRDTN_LICENSE := Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
IBRDTN_CONF_TOOL := autoconf
IBRDTN_CONF_OPT  := $(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_IBRDTN_ENABLE_DEBUG    )-debug       \
	--$(call ptx/wwo,   PTXCONF_IBRDTN_WITH_COMPRESSION)-compression \
	--$(call ptx/wwo,   PTXCONF_IBRDTN_WITH_GLIB       )-glib        \

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ibrdtn.targetinstall:
	@$(call targetinfo)

	@$(call install_init,   ibrdtn)
	@$(call install_fixup,  ibrdtn,PRIORITY,optional)
	@$(call install_fixup,  ibrdtn,SECTION,base)
	@$(call install_fixup,  ibrdtn,AUTHOR,"Roland Hieber <rohieb@rohieb.name>")
	@$(call install_fixup,  ibrdtn,DESCRIPTION,missing)

	@$(call install_lib,    ibrdtn, 0, 0, 0755, libibrdtn-1.0)

	@$(call install_finish, ibrdtn)

	@$(call touch)

# vim: syntax=make
