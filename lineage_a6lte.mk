#
# Copyright (C) 2019 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Inherit from those products. Most specific first.
# SM-A600FN launched on Android 8.0 (API 26).
$(call inherit-product, $(SRC_TARGET_DIR)/product/product_launched_with_o.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# RisingOS COMMUNITY build with the CORE (pico) GApps set. The full GApps
# package exceeds the Galaxy A6's fixed 4 GiB system partition.
WITH_GMS := true
WITH_ADB_INSECURE := true
RISING_MAINTAINER := kejlo
TARGET_ENABLE_BLUR := false
PRODUCT_NO_CAMERA := false
TARGET_USES_PICO_GAPPS := true

# The Android 17 WebApp SDK prebuilt currently conflicts with its disabled
# source implementation during the legacy monolithic Soong analysis.  The
# incremental analyzer selects the source APEX correctly and also keeps peak
# memory use within reach of this build host.
PRODUCT_SOONG_INCREMENTAL_ANALYSIS := true

PRODUCT_BUILD_PROP_OVERRIDES += \
    RisingChipset="Samsung Exynos 7870" \
    RisingMaintainer="kejlo"

# Export the Soong libraries consumed by the legacy Android.mk-based 7870
# graphics and OpenMAX stacks.
PRODUCT_SOONG_NAMESPACES += \
    hardware/broadcom/libbt \
    hardware/google/pixel/power-libperfmgr \
    hardware/samsung_slsi-linaro/exynos \
    hardware/samsung_slsi-linaro/graphics

# This checkout also contains an unrelated Galaxy S10e port.  Do not feed its
# device/vendor/kernel blueprints into the a6lte Soong graph.
PRODUCT_SOURCE_ROOT_DIRS += \
    -device/samsung/beyond0lte \
    -device/samsung/exynos9820-common \
    -kernel/samsung/exynos9820 \
    -hardware/samsung_slsi-linaro/exynos/abox \
    -hardware/samsung_slsi-linaro/exynos/c2service \
    -hardware/samsung_slsi-linaro/exynos/exyrngd \
    -hardware/samsung_slsi-linaro/exynos/gralloc1 \
    -hardware/samsung_slsi-linaro/exynos/gralloc4 \
    -hardware/samsung_slsi-linaro/exynos/libdisplaycolor \
    -hardware/samsung_slsi-linaro/exynos/libdisplaycolor/unittest \
    -hardware/samsung_slsi-linaro/exynos/libeis_utils \
    -hardware/samsung_slsi-linaro/exynos/libhdr \
    -hardware/samsung_slsi-linaro/exynos/libhdr/unittest \
    -hardware/samsung_slsi-linaro/exynos/libsbwcdecomp \
    -hardware/samsung_slsi-linaro/exynos/libsbwchelper \
    -hardware/samsung_slsi-linaro/exynos/libsbwcwrapper \
    -hardware/samsung_slsi-linaro/exynos/libvision \
    -hardware/samsung_slsi-linaro/exynos/ssp \
    -hardware/samsung_slsi-linaro/exynos/tee \
    -hardware/samsung_slsi-linaro/exynos/videoapi \
    -hardware/samsung_slsi-linaro/exynos/weaver \
    -hardware/samsung_slsi-linaro/interfaces/SbwcDecompService \
    -vendor/samsung/beyond0lte \
    -vendor/samsung/exynos9820-common

# Inherit from a6lte device
$(call inherit-product, device/samsung/a6lte/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

# Device identifier. This must come after all inclusions
PRODUCT_DEVICE := a6lte
PRODUCT_NAME := lineage_a6lte
PRODUCT_BRAND := samsung
PRODUCT_MODEL := Galaxy A6 2018
PRODUCT_MANUFACTURER := samsung

TARGET_VENDOR := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung

TARGET_BOOT_ANIMATION_RES := 720
TARGET_GAPPS_ARCH := arm64
