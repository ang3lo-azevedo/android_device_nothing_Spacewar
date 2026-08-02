# Device Tree for Nothing Phone (1) (Spacewar)

Device tree for building VoltageOS and other AOSP-based ROMs for the Nothing Phone (1).

## Source History

This tree is a merge of improvements from multiple Spacewar maintainers:

| Base | Branch | Source |
|------|--------|--------|
| kleidione | `bp4a` | NOS 3.2 fixes, vibrator, FP permissions, power profile |
| DaViDev985 | `derp16.2` | NOS 3.2 post_boot.sh, sepolicy perf, FP screen-off unlock |
| smrth097 | `16.2-clean` | Keyguard margin fix, vibrate on icon animation |
| crDroid | `16.0` | NOS 3.2 mixer paths, camcorder audio fix, radio power saving, Bluetooth ASHA/AptX |
| halogenOS | `XOS-16.2` | Linear-nits brightness mapping, Extra Dim evening dimmer config |
| VoltageOS | custom | LTO/O3 optimizations, DeviceAsWebcam, NGlyphs migration |

## Features

- NGlyphs (replaces ParanoidGlyph) - system app for glyph LED control, no root needed
- NOS 3.2 vibrator improvements (amplitude, richtap consistency, effect remapping)
- FP screen-off unlock enabled by default
- NOS 3.2 post_boot.sh and power profile
- Recovery ADSP battery monitoring
- Device as Webcam support (HQ mode default)
- Dolby audio integration
- Nothing Camera with video recording fix
- LTO + O3 + ThinLTO optimizations
- HWUI compile for performance

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
