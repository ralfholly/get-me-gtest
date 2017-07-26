#
# Gets Google Test releases from GitHub and builds them.
# Copyright 2017 Ralf Holly. See LICENSE file for details.
#

GOOGLE_TEST_ARCHIVE := $(VERSION).tar.gz
GOOGLE_TEST_ARCHIVE_URL := https://github.com/google/googletest/archive/$(GOOGLE_TEST_ARCHIVE)
GOOGLE_TEST_TAGS_URL := https://api.github.com/repos/google/googletest/tags
GOOGLE_TEST_BIN := googletest-$(VERSION)

ifneq ($(MAKECMDGOALS), list)
ifeq ("$(VERSION)","")
$(error Please define VERSION, ie. run `make VERSION=release-1.8.0' or `make list' to get a list of available versions.)
endif
endif

.PHONY: list all

all:
	wget $(GOOGLE_TEST_ARCHIVE_URL)
	tar xf $(GOOGLE_TEST_ARCHIVE)
	rm $(GOOGLE_TEST_ARCHIVE)
	cd $(GOOGLE_TEST_BIN) ; cmake . ; make -j

list:
	$(eval versions := $(shell wget $(GOOGLE_TEST_TAGS_URL) -O - -q | grep \"name\" | sed -r -e 's|\s*\"name\"\s*:\s*\"([^"]+)\"\s*,|\1|'))
	$(foreach version,$(versions),$(info $(version)))
	@echo -n
