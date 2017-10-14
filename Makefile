#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation; either version 2 of the License, or (at your option) any later
# version.  This program is distributed in the hope that it will be useful, but
# without any warranty; without even the implied warranty of mechantability or
# fitness for a particular purpose.  See the GNU General Public License for
# more details.  You should have received a copy of the GNU General Public
# License along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
# Nathan L. Conrad <nathan@noreply.alt-teknik.com>
#

ifneq ($(KERNELRELEASE),)
	obj-y := net/can/
else
	KERNELDIR ?= /lib/modules/$(shell uname -r)/build
	PWD := $(shell pwd)
modules:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) PROJECT_DIR=$(PWD) modules
modules_install:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) modules_install
endif
.PHONY: clean
clean:
	@find -type f '(' -name '.*.cmd' -o -name '*.ko' -o -name '*.o' -o \
		-name '*.mod.c' -o -name 'modules.order' ')' -delete
	@rm -rf .tmp_versions
	@rm -f Module.symvers
