#!/bin/sh
# Fix vendor blobs for Android 17 compatibility
VENDOR_ANDROID_BP=vendor/nothing/Spacewar/Android.bp
VENDOR_MK=vendor/nothing/Spacewar/Spacewar-vendor.mk
[ -f "$VENDOR_ANDROID_BP" ] || exit 0

# Fix audio types V4->V5 (required for A17, V4 removed from platform)
sed -i "s/android\.media\.audio\.common\.types-V4-cpp/android.media.audio.common.types-V5-cpp/g" "$VENDOR_ANDROID_BP"

# Remove PowerOffAlarm from packages (removed in A17)
sed -i "/PowerOffAlarm/d" "$VENDOR_MK"
