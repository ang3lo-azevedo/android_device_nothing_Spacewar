#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
TARGET_SUPPORTS_OMX_SERVICE := false
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from Spacewar device
$(call inherit-product, device/nothing/Spacewar/device.mk)

# Fix duplicate sysprop: ROM audio defaults use = instead of ?=
$(shell sed -i 's/ro.config.ringtone=/ro.config.ringtone?=/; s/ro.config.alarm_alert=/ro.config.alarm_alert?=/; s/ro.config.notification_sound=/ro.config.notification_sound?=/' vendor/voltage/audio/audio.mk 2>/dev/null; true)

# Fetch KernelSU source if missing (required by KSU-SUSFS kernel)
$(shell if [ ! -f kernel/nothing/sm7325/KernelSU/kernel/Kconfig ]; then \
    rm -rf kernel/nothing/sm7325/KernelSU && \
    cd kernel/nothing/sm7325 && curl -LSs "https://raw.githubusercontent.com/William24hmar/KernelSU/master/kernel/setup.sh" | bash -s master-susfs 2>/dev/null; \
fi; true)

# Inherit some common Voltage stuff.
$(call inherit-product, vendor/voltage/config/common_full_phone.mk)

# Boost Framework configuration for Snapdragon 778G+
VOLTAGE_CPU_SMALL_CORES := 0,1,2,3
VOLTAGE_CPU_BIG_CORES := 4,5,6,7
VOLTAGE_CPU_BG := 0-2
VOLTAGE_CPU_FG := 0-7
VOLTAGE_CPU_LIMIT_BG := 0-1
VOLTAGE_CPU_UNLIMIT_UI := 0-7
VOLTAGE_CPU_LIMIT_UI := 0-5

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
    BuildFingerprint="Nothing/Spacewar/Spacewar:12/SKQ1.211230.001/1666412462:user/release-keys"

# ADB USB debugging enabled by default
PRODUCT_PRODUCT_PROPERTIES += \
    persist.sys.usb.config=adb
