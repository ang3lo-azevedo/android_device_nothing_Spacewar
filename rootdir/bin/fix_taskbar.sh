#!/vendor/bin/sh
# Fix taskbar by restarting launcher after boot completes
sleep 15
while ! pidof com.android.launcher3 > /dev/null 2>&1; do sleep 1; done
sleep 5
am force-stop com.android.launcher3
