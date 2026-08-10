#!/bin/sh
# Replace vendor camera calibration files with crDroid versions
SRC=device/nothing/Spacewar/configs/camera
DST=vendor/nothing/Spacewar/proprietary/vendor/etc/camera
[ -d "$SRC" ] && [ -d "$DST" ] || exit 0
cp -f "$SRC"/camxoverridesettings.txt "$DST"/camxoverridesettings.txt 2>/dev/null || true
