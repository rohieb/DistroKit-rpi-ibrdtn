# -*-makefile-*-
#
# Copyright (C) 2016 by Roland Hieber <rohieb@rohieb.name>
#

#
# We provide this package
#
PACKAGES-$(PTXCONF_IBRDTND) += ibrdtnd

#
# Paths and names
#
IBRDTND_VERSION := 1.0.1
IBRDTND_MD5     := 933d37bf777700a6e1709d0f7a129613
IBRDTND         := ibrdtnd-$(IBRDTND_VERSION)
IBRDTND_SUFFIX  := tar.gz
IBRDTND_URL     := https://www.ibr.cs.tu-bs.de/projects/ibr-dtn/releases/$(IBRDTND).$(IBRDTND_SUFFIX)
IBRDTND_SOURCE  := $(SRCDIR)/$(IBRDTND).$(IBRDTND_SUFFIX)
IBRDTND_DIR     := $(BUILDDIR)/$(IBRDTND)
IBRDTND_LICENSE := Apache-2.0

# ----------------------------------------------------------------------------
# Prepare
# ----------------------------------------------------------------------------

#
# autoconf
#
IBRDTND_CONF_TOOL := autoconf
# Notes: --without-vmime:   libvmime is not packaged yet
#        --without-wifip2p: wifip2p  is not packaged yet
#        --disable-docs:    docs would depend on pdfLaTeX
IBRDTND_CONF_OPT  := $(CROSS_AUTOCONF_USR) \
	--disable-docs                           \
	--without-vmime                          \
	--without-wifip2p                        \
	--$(call ptx/endis, PTXCONF_IBRDTND_ENABLE_DEBUG    )-debug       \
	--$(call ptx/endis, PTXCONF_IBRDTND_ENABLE_DAEMON   )-libdaemon   \
	--$(call ptx/endis, PTXCONF_IBRDTND_ENABLE_DTNDHT   )-dtndht      \
	--$(call ptx/wwo,   PTXCONF_IBRDTND_WITH_SQLITE     )-sqlite      \
	--$(call ptx/wwo,   PTXCONF_IBRDTND_WITH_TLS        )-tls         \
	--$(call ptx/wwo,   PTXCONF_IBRDTND_WITH_LIBCURL    )-curl        \

# ----------------------------------------------------------------------------
# Target-Install
# ----------------------------------------------------------------------------

$(STATEDIR)/ibrdtnd.targetinstall:
	@$(call targetinfo)

	@$(call install_init,        ibrdtnd)
	@$(call install_fixup,       ibrdtnd,PRIORITY,optional)
	@$(call install_fixup,       ibrdtnd,SECTION,base)
	@$(call install_fixup,       ibrdtnd,AUTHOR,"Roland Hieber <rohieb@rohieb.name>")
	@$(call install_fixup,       ibrdtnd,DESCRIPTION,missing)

	@$(call install_copy,        ibrdtnd, 0, 0, 0755, -, /usr/sbin/dtnd)
ifdef PTXCONF_IBRDTND_WITH_TLS
	@$(call install_copy,        ibrdtnd, 0, 0, 0755, -, /usr/bin/ibrdtn-genkey.sh)
endif
	@$(call install_copy,        ibrdtnd, 0, 0, 0644, -, /etc/ibrdtnd.conf)

ifdef PTXCONF_IBRDTND_SYSTEMD_UNIT
	@$(call install_alternative, ibrdtnd, 0, 0, 0644, /lib/systemd/system/ibrdtnd.service)
	@$(call install_link,        ibrdtnd, ../ibrdtnd.service, /lib/systemd/system/multi-user.target.wants/ibrdtnd.service)
endif

	@$(call install_finish,      ibrdtnd)

	@$(call touch)

# vim: syntax=make
