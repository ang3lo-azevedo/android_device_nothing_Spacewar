#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Android 17 release config
TARGET_RELEASE := trunk_staging

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
TARGET_SUPPORTS_OMX_SERVICE := false
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from Spacewar device
$(call inherit-product, device/nothing/Spacewar/device.mk)

# Inherit some common Voltage stuff.
$(call inherit-product, vendor/voltage/config/common_full_phone.mk)

# Device identifier. This must come after all inclusions.
PRODUCT_NAME := voltage_Spacewar
PRODUCT_DEVICE := Spacewar
PRODUCT_BRAND := Nothing
PRODUCT_MODEL := A063
PRODUCT_MANUFACTURER := Nothing

PRODUCT_CHARACTERISTICS := nosdcard

# Attestation and Play Protect certification properties
PRODUCT_MANUFACTURER_FOR_ATTESTATION := Nothing
PRODUCT_BRAND_FOR_ATTESTATION := Nothing
PRODUCT_DEVICE_FOR_ATTESTATION := Spacewar
PRODUCT_NAME_FOR_ATTESTATION := Spacewar
PRODUCT_MODEL_FOR_ATTESTATION := A063

PRODUCT_GMS_CLIENTID_BASE := android-nothing

PRODUCT_BUILD_PROP_OVERRIDES += \
    DeviceProduct=Spacewar \
    BuildFingerprint="Nothing/Spacewar/Spacewar:15/AQ3A.240929.001/2604161140:user/release-keys"

# Fix duplicate sysprop: ROM audio defaults use = instead of ?=
$(shell sed -i 's/ro.config.ringtone=/ro.config.ringtone?=/; s/ro.config.alarm_alert=/ro.config.alarm_alert?=/; s/ro.config.notification_sound=/ro.config.notification_sound?=/' vendor/voltage/audio/audio.mk 2>/dev/null; true)

# Fetch KernelSU source if missing (required by KSU-SUSFS kernel)
$(shell if [ ! -f kernel/nothing/sm7325/KernelSU/kernel/Kconfig ]; then \
    rm -rf kernel/nothing/sm7325/KernelSU && \
    git clone -b master-susfs --depth 1 https://github.com/William24hmar/KernelSU.git kernel/nothing/sm7325/KernelSU 2>/dev/null; \
fi; \
sh device/nothing/Spacewar/rootdir/bin/fix_ksu_dupes.sh > /dev/null 2>&1; \
true)
# Replace vendor camxoverridesettings.txt with crDroid version
$(shell sh device/nothing/Spacewar/rootdir/bin/fix_camera_configs.sh)

