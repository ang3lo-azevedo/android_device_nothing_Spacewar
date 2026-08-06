#!/vendor/bin/sh
# Fix taskbar by restarting launcher after user unlock
sleep 3
while ! pidof com.android.launcher3 > /dev/null 2>&1; do sleep 1; done
sleep 2
pkill -f com.android.launcher3
