ESCRIPTION = "VEK280 TRD related Packages"

COMPATIBLE_MACHINE:versal = ".*"

inherit packagegroup

PYTHON_MODULE_OXRT = " \
	python3-protobuf \
	python3-flatbuffers \
	python3-coloredlogs \
	python3-mpmath \
	python3-sympy \
	python3-humanfriendly \
"

BASE_TRD_PACKAGES = " \
	packagegroup-petalinux-self-hosted \
	packagegroup-petalinux-x11 \
	packagegroup-core-tools-debug \
	packagegroup-petalinux-opencv \
	packagegroup-petalinux-opencv-dev \
	packagegroup-petalinux-v4lutils \
	vitis-ai-library \
	vitis-ai-library-dev \
	vai-benchmark \
	opencv-staticdev \
	cpufrequtils \
	resize-part \
	auto-resize \
	dnf \
	nfs-utils \
	ldd \
	ntp \
	python3-dev \
	python3-periphery \
	tcf-agent \
	ttf-bitstream-vera \
	tzdata \
	tree \
	cmake \
	zocl \
	xrt \
	xrt-dev \
	${PYTHON_MODULE_OXRT} \
	"

RDEPENDS:${PN} += "${BASE_TRD_PACKAGES}"
