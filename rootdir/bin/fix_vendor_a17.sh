#!/bin/sh
# Fix vendor blobs for Android 17 compatibility
VENDOR_ANDROID_BP=vendor/nothing/Spacewar/Android.bp
VENDOR_MK=vendor/nothing/Spacewar/Spacewar-vendor.mk

# 1. Add allow_undefined_symbols for audio library
sed -i '/compile_multilib: "64",/,/system_ext_specific: true,/{
    /system_ext_specific: true,/a\    allow_undefined_symbols: true,
}' "$VENDOR_ANDROID_BP"

# 2. Fix audio types V4->V5
sed -i 's/android.media.audio.common.types-V4-cpp/android.media.audio.common.types-V5-cpp/g' "$VENDOR_ANDROID_BP"

# 3. Add check_elf_files: false for wfd library
sed -i '/libwfdmmsrc_system/,/system_ext_specific: true,/{
    /system_ext_specific: true,/a\    check_elf_files: false,
}' "$VENDOR_ANDROID_BP"

# 4. Remove PowerOffAlarm from packages
sed -i '/PowerOffAlarm/d' "$VENDOR_MK"

echo "Vendor patched for Android 17"
