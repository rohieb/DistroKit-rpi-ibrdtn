# -*-makefile-*-
#
# Copyright (C) 2016 by Roland Hieber <rohieb@rohieb.name>
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IBRCOMMON) += ibrcommon

#
# Paths and names
#
IBRCOMMON_VERSION := 1.0.1
IBRCOMMON_MD5     := 0104763ede969c470f32244d76c234b8
IBRCOMMON         := ibrcommon-$(IBRCOMMON_VERSION)
IBRCOMMON_SUFFIX  := tar.gz
IBRCOMMON_URL     := https://www.ibr.cs.tu-bs.de/projects/ibr-dtn/releases/$(IBRCOMMON).$(IBRCOMMON_SUFFIX)
IBRCOMMON_SOURCE  := $(SRCDIR)/$(IBRCOMMON).$(IBRCOMMON_SUFFIX)
IBRCOMMON_DIR     := $(BUILDDIR)/$(IBRCOMMON)
IBRCOMMON_LICENSE := Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
IBRCOMMON_CONF_TOOL := autoconf
IBRCOMMON_CONF_OPT  := $(CROSS_AUTOCONF_USR) \
	--$(call ptx/endis, PTXCONF_IBRCOMMON_ENABLE_DEBUG)-debug   \
	--$(call ptx/wwo,   PTXCONF_IBRCOMMON_WITH_LOWPAN )-lowpan  \
	--$(call ptx/wwo,   PTXCONF_IBRCOMMON_WITH_OPENSSL)-openssl \
	--$(call ptx/wwo,   PTXCONF_IBRCOMMON_WITH_XML    )-xml     \

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ibrcommon.targetinstall:
	@$(call targetinfo)

	@$(call install_init,   ibrcommon)
	@$(call install_fixup,  ibrcommon,PRIORITY,optional)
	@$(call install_fixup,  ibrcommon,SECTION,base)
	@$(call install_fixup,  ibrcommon,AUTHOR,"Roland Hieber <rohieb@rohieb.name>")
	@$(call install_fixup,  ibrcommon,DESCRIPTION,missing)

	@$(call install_lib,    ibrcommon, 0, 0, 0755, libibrcommon-1.0)

	@$(call install_finish, ibrcommon)

	@$(call touch)

# vim: syntax=make
