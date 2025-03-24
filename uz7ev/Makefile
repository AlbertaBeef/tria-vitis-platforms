
CP = cp -f

PWD = $(shell readlink -f .)

# the platform directory has to be an absolute path when passed to v++
PFM_DIR = $(PWD)/platforms
PFM_VER = 2024_2

# valid platforms / overlays
PFM_LIST = uz7ev_evcc_base uz7ev_evcc_nvme uz7ev_evcc_camerafmc
OVERLAY_LIST =  benchmark

# override platform name based on overlay
ifeq ($(OVERLAY),benchmark)
  override PFM = uz7ev_evcc_nvme
endif

PFM_XPFM = $(PFM_DIR)/tria_$(PFM)_$(PFM_VER)/$(PFM).xpfm

VITIS_DIR = overlays/examples
VITIS_OVERLAY_DIR = $(VITIS_DIR)/$(OVERLAY)
VITIS_OVERLAY_BIT = $(VITIS_OVERLAY_DIR)/binary_container_1/link/int/system.bit

.PHONY: help
help:
	@echo 'Usage:'
	@echo ''
	@echo '  make platform PFM=<val> JOBS=<n>'
	@echo '    Build the Vitis platform.'
	@echo ''
	@echo '    Valid options for PFM: ${PFM_LIST}'
	@echo '    JOBS: optional param to set number of synthesis jobs (default 8)'
	@echo ''
	@echo '  make overlay OVERLAY=<val>'
	@echo '    Build the Vitis application overlay.'
	@echo ''
	@echo '    Valid options for OVERLAY: ${OVERLAY_LIST}'
	@echo ''
	@echo '  make petalinux'
	@echo '    Build the petalinux project.'
	@echo ''
	@echo '  make clean'
	@echo '    Clean runs'
	@echo ''

.PHONY: petalinux
petalinux: 
	@if [ -d petalinux/.petalinux ]; then  \
	  echo 'Reusing existing petalinux/.petalinux files ...'; \
	else \
	  echo 'Creating new petalinux/.petalinux files ...'; \
	  mkdir -p petalinux/.petalinux; \
	  echo PETALINUX=2024.2 > petalinux/.petalinux/metadata; \
	fi
	@if [ -d petalinux/project-spec/hw-description ]; then  \
	  echo 'Reusing existing petalinux/project-spec/hw-description files ...'; \
	else \
	  echo 'Creating new petalinux/project-spec/hw-description files ...'; \
	  mkdir -p petalinux/project-spec/hw-description; \
	  touch petalinux/project-spec/hw-description/metadata; \
	fi
	echo 'Configuring petalinux project ...'
	cd petalinux; \
	petalinux-config --silentconfig --get-hw-description=../platforms/vivado/uz7ev_evcc_nvme/project/uz7ev_evcc_nvme.xsa
	echo 'Building petalinux project ...'
	cd petalinux; \
	petalinux-build

.PHONY: overlay
overlay: $(VITIS_OVERLAY_BIT)
$(VITIS_OVERLAY_BIT): $(PFM_XPFM)
	@valid=0; \
	for o in $(OVERLAY_LIST); do \
	  if [ "$$o" = "$(OVERLAY)" ]; then \
	    valid=1; \
	    break; \
	  fi \
	done; \
	if [ "$$valid" -ne 1 ]; then \
	  echo 'Invalid parameter OVERLAY=$(OVERLAY). Choose one of: $(OVERLAY_LIST)'; \
	  exit 1; \
	fi; \
	echo 'Build $(OVERLAY) Vitis overlay using platform $(PFM)'; \
	$(MAKE) -C $(VITIS_OVERLAY_DIR) all PLATFORM=$(PFM_XPFM)

.PHONY: platform
platform: $(PFM_XPFM)
$(PFM_XPFM):
	@valid=0; \
	for p in $(PFM_LIST); do \
	  if [ "$$p" = "$(PFM)" ]; then \
	    valid=1; \
	    break; \
	  fi \
	done; \
	if [ "$$valid" -ne 1 ]; then \
	  echo 'Invalid parameter PFM=$(PFM). Choose one of: $(PFM_LIST)'; \
	  exit 1; \
	fi; \
	echo 'Create Vitis platform $(PFM)'; \
	$(MAKE) -C $(PFM_DIR) platform PLATFORM=$(PFM) VERSION=$(PFM_VER)

.PHONY: clean
clean:
	$(foreach o, $(OVERLAY_LIST), $(MAKE) -C $(VITIS_DIR)/$(o) clean;)
	$(foreach p, $(PFM_LIST), $(MAKE) -C $(PFM_DIR) clean PLATFORM=$(p) VERSION=$(PFM_VER);)
