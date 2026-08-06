#!/system/bin/sh
# Restart launcher to activate taskbar after boot
sleep 3
am force-stop com.android.launcher3
