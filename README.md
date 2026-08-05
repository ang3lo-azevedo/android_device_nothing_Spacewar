# Device Tree for Nothing Phone (1) (Spacewar)

Device tree for building VoltageOS and other AOSP-based ROMs for the Nothing Phone (1).

## Source History

This tree is a merge of improvements from multiple Spacewar maintainers:

| Base | Branch | Source |
|------|--------|--------|
| [kleidione](https://github.com/kleidione) | [`bp4a`](https://github.com/kleidione/device_nothing_Spacewar) | Device tree base, NOS 3.2 fixes, vibrator, FP permissions, power profile |
| [DaViDev985](https://github.com/DaViDev985) | [`derp16.2`](https://github.com/DaViDev985/device_nothing_Spacewar) | NOS 3.2 post_boot.sh, sepolicy perf, FP screen-off unlock |
| [smrth097](https://github.com/smrth097) | [`16.2-clean`](https://github.com/smrth097/android_device_nothing_Spacewar) | Perf init script, IRQ balance config, SPAMMY_LOG_TAGS, QTI vndfwk, WiFi secondary STA, keyguard margin fix, vibrate on icon animation |
| [crDroid](https://github.com/crdroidandroid) | [`16.0`](https://github.com/crdroidandroid/android_device_nothing_Spacewar) | NOS 3.2 mixer paths, camcorder audio fix, radio power saving, Bluetooth ASHA/AptX/HD/Adaptive/LDAC, sensor calibration libs, camera soong configs, audio skip_speaker |
| [halogenOS](https://github.com/halogenOS) | [`XOS-16.2`](https://github.com/halogenOS/android_device_nothing_Spacewar) | Linear-nits brightness mapping, Extra Dim evening dimmer config |
| [StudioKeys-Dumps](https://github.com/StudioKeys-Dumps) | N/A | NGlyphs (via hardware/nothing), recovery ADSP battery monitoring |

## Features

- Nothing Camera with video recording fix (libui-v34, 14 arcsoft libs)
- Google Camera (from kleidione's vendor)
- NGlyphs - system app for glyph LED control, no root needed
- KernelSU with syscall tamper and full SUSFS (root hiding)
- NetHunter support (Wi-Fi monitor mode, HID, USB gadgets, WireGuard)
- OrangeFox recovery compatible (TARGET_NO_RECOVERY set)
- Perf init script (CPU boost, schedutil tuning, uclamp priority)
- IRQ affinity config (prevents display/GPU micro-stutter)
- WiFi concurrent STA (hotspot + WiFi simultaneously)
- NOS 3.2 vibrator improvements (amplitude, richtap consistency, effect remapping)
- FP screen-off unlock enabled by default
- NOS 3.2 post_boot.sh and power profile
- Recovery ADSP battery monitoring
- Device as Webcam support
- ADB USB debugging enabled by default
- Dolby audio integration
- Display linear-nits brightness mapping with Extra Dim
- Bluetooth codecs: ASHA, AptX/HD/Adaptive, LDAC, AAC

## Build

```bash
source build/envsetup.sh
breakfast Spacewar
brunch Spacewar
```

## Credits

- [kleidione](https://github.com/kleidione) - device tree base, FP fix, ghost touch fix
- [DaViDev985](https://github.com/DaViDev985) - vendor blobs, camera, NOS 3.2 fixes
- [smrth097](https://github.com/smrth097) - perf tuning, IRQ balance, WiFi improvements
- [Jis G Jacob (StudioKeys)](https://github.com/StudioKeys-Dumps) - NGlyphs, recovery ADSP patch
- [William24hmar](https://github.com/William24hmar) - kernel source
- [rodrig20](https://github.com/rodrig20) - USB gadget improvements
- [LineageOS](https://github.com/LineageOS) - hardware/nothing base
- [crDroid](https://github.com/crdroidandroid) - Bluetooth, camera, and radio improvements
- [halogenOS](https://github.com/halogenOS) - Display brightness and Extra Dim improvements
- [VoltageOS](https://github.com/VoltageOS) - ROM platform
