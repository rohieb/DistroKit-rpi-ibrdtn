# -*-makefile-*-
#
# Copyright (C) 2016 by Roland Hieber <rohieb@rohieb.name>
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IBRDTN_TOOLS) += ibrdtn-tools

#
# Paths and names
#
IBRDTN_TOOLS_VERSION := 1.0.1
IBRDTN_TOOLS_MD5     := 3e527cedc6132739403fc210e4f8abe2
IBRDTN_TOOLS         := ibrdtn-tools-$(IBRDTN_TOOLS_VERSION)
IBRDTN_TOOLS_SUFFIX  := tar.gz
IBRDTN_TOOLS_URL     := https://www.ibr.cs.tu-bs.de/projects/ibr-dtn/releases/$(IBRDTN_TOOLS).$(IBRDTN_TOOLS_SUFFIX)
IBRDTN_TOOLS_SOURCE  := $(SRCDIR)/$(IBRDTN_TOOLS).$(IBRDTN_TOOLS_SUFFIX)
IBRDTN_TOOLS_DIR     := $(BUILDDIR)/$(IBRDTN_TOOLS)
IBRDTN_TOOLS_LICENSE := Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
# Note: --without-tffs:  tffs is not yet packaged
IBRDTN_TOOLS_CONF_TOOL := autoconf
IBRDTN_TOOLS_CONF_OPT  := $(CROSS_AUTOCONF_USR) \
	--without-tffs                                \
	--$(call ptx/endis, PTXCONF_IBRDTN_TOOLS_ENABLE_DEBUG    )-debug       \
	--$(call ptx/wwo,   PTXCONF_IBRDTN_TOOLS_WITH_LIBDAEMON  )-libdaemon   \
	--$(call ptx/wwo,   PTXCONF_IBRDTN_TOOLS_WITH_LIBARCHIVE )-libarchive  \

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ibrdtn-tools.targetinstall:
	@$(call targetinfo)

	@$(call install_init,   ibrdtn-tools)
	@$(call install_fixup,  ibrdtn-tools,PRIORITY,optional)
	@$(call install_fixup,  ibrdtn-tools,SECTION,base)
	@$(call install_fixup,  ibrdtn-tools,AUTHOR,"Roland Hieber <rohieb@rohieb.name>")
	@$(call install_fixup,  ibrdtn-tools,DESCRIPTION,missing)

	@$(call install_copy,   ibrdtn-tools, 0, 0, 0755, -, /usr/bin/dtnstream    )
	@$(call install_copy,   ibrdtn-tools, 0, 0, 0755, -, /usr/bin/dtnrecv      )
	@$(call install_copy,   ibrdtn-tools, 0, 0, 0755, -, /usr/bin/dtntrigger   )
	@$(call install_copy,   ibrdtn-tools, 0, 0, 0755, -, /usr/bin/dtnconvert   )
	@$(call install_copy,   ibrdtn-tools, 0, 0, 0755, -, /usr/bin/dtnping      )
	@$(call install_copy,   ibrdtn-tools, 0, 0, 0755, -, /usr/bin/dtntracepath )
	@$(call install_copy,   ibrdtn-tools, 0, 0, 0755, -, /usr/bin/dtnsend      )
	@$(call install_copy,   ibrdtn-tools, 0, 0, 0755, -, /usr/sbin/dtntunnel   )
ifdef IBRDTN_TOOLS_WITH_LIBARCHIVE
	@$(call install_copy,   ibrdtn-tools, 0, 0, 0755, -, /usr/bin/dtninbox     )
	@$(call install_copy,   ibrdtn-tools, 0, 0, 0755, -, /usr/bin/dtnoutbox    )
endif

	@$(call install_finish, ibrdtn-tools)

	@$(call touch)

# vim: syntax=make
