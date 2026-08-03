# Device Tree for Nothing Phone (1) (Spacewar)

Device tree for building VoltageOS and other AOSP-based ROMs for the Nothing Phone (1).

## Source History

This tree is a merge of improvements from multiple Spacewar maintainers:

| Base | Branch | Source |
|------|--------|--------|
| [kleidione](https://github.com/kleidione) | [`bp4a`](https://github.com/kleidione/device_nothing_Spacewar) | NOS 3.2 fixes, vibrator, FP permissions, power profile |
| [DaViDev985](https://github.com/DaViDev985) | [`derp16.2`](https://github.com/DaViDev985/device_nothing_Spacewar) | NOS 3.2 post_boot.sh, sepolicy perf, FP screen-off unlock |
| [smrth097](https://github.com/smrth097) | [`16.2-clean`](https://github.com/smrth097/android_device_nothing_Spacewar) | Keyguard margin fix, vibrate on icon animation |
| [crDroid](https://github.com/crdroidandroid) | [`16.0`](https://github.com/crdroidandroid/android_device_nothing_Spacewar) | NOS 3.2 mixer paths, camcorder audio fix, radio power saving, Bluetooth ASHA/AptX |
| [halogenOS](https://github.com/halogenOS) | [`XOS-16.2`](https://github.com/halogenOS/android_device_nothing_Spacewar) | Linear-nits brightness mapping, Extra Dim evening dimmer config |
| [VoltageOS](https://github.com/VoltageOS) | custom | LTO/O3 optimizations, DeviceAsWebcam, NGlyphs migration |

## Features

- Nothing Camera with video recording fix (libui-v34, vidhance blob fixup, 14 arcsoft libs)
- Google Camera (from kleidione's vendor)
- NGlyphs (replaces ParanoidGlyph) - system app for glyph LED control, no root needed
- KernelSU with syscall tamper and full SUSFS (root hiding)
- OrangeFox recovery compatible (TARGET_NO_RECOVERY set)
- NOS 3.2 vibrator improvements (amplitude, richtap consistency, effect remapping)
- FP screen-off unlock enabled by default
- NOS 3.2 post_boot.sh and power profile
- Recovery ADSP battery monitoring
- ADB USB debugging enabled by default
- Dolby audio integration
- LTO + O3 + ThinLTO optimizations
- HWUI compile for performance
- Display linear-nits brightness mapping with Extra Dim

## Build

```bash
source build/envsetup.sh
breakfast Spacewar
brunch Spacewar
```

## Credits

- [kleidione](https://github.com/kleidione) - device tree base, FP fix, ghost touch fix
- [DaViDev985](https://github.com/DaViDev985) - vendor blobs, camera, NOS 3.2 fixes
- [smrth097](https://github.com/smrth097) - original Spacewar bringup
- [Jis G Jacob (StudioKeys)](https://github.com/StudioKeys-Dumps) - NGlyphs, recovery ADSP patch
- [William24hmar](https://github.com/William24hmar) - kernel source
- [LineageOS](https://github.com/LineageOS) - hardware/nothing base
- [crDroid](https://github.com/crdroidandroid) - Bluetooth and radio improvements
- [halogenOS](https://github.com/halogenOS) - Display brightness and Extra Dim improvements
- [VoltageOS](https://github.com/VoltageOS) - ROM platform
