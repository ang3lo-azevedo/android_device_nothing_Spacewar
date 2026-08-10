# Device Tree: Nothing Phone (1) — Spacewar

Android 17 (cp2a) device tree for [VoltageOS](https://voltage-os.xyz/).

## Base

[StudioKeys-Dumps cp2a](https://github.com/StudioKeys-Dumps/device_nothing_Spacewar) branch.

## Features

| Feature | Source | Description |
|---------|--------|-------------|
| Camera calibration files | crDroid | `camxoverridesettings.txt`, `camera_config.xml`, `camera_feature.xml` for Nothing Camera support |
| Perf init script | smrth097 | CPU boost, schedutil tuning, uclamp |
| IRQ balance | smrth097 | `msm_irqbalance.conf` (GPU micro-stutter prevention) |
| WiFi concurrent STA | smrth097 | Hotspot + WiFi simultaneous |
| SPAMMY_LOG_TAGS | smrth097 | Cleaner logcat |
| QTI vndfwk | smrth097 | CNE networking fix |
| Linear-nits brightness | halogenOS | Extra Dim evening dimmer config |
| NGlyphs | StudioKeys-Dumps | Glyph LED HAL (no root needed, audio-glyph sync, music visualizer, recording LED) |
| ArcSoft libs | LineageOS | Camera processing libraries |
| Skip speaker audio | LineageOS | Audio HAL fix |
| KernelSU | — | KSU-SUSFS kernel (separate repo) |
| Droidspaces | — | Container support (cgroups, namespaces, devtmpfs, netfilter) |
| Device-as-Webcam | — | Declared intent (QTI 5.4 UVC limitation — see kernel README) |
| FOR_ATTESTATION | — | Play Integrity attestation props |
| VoltageOS inherit | — | `common_full_phone.mk` (not LineageOS) |

## Build Fixes

- ~~`config_enableTaskbar`~~ — removed (A16 leftover)
- Merge conflict markers resolved
- `TARGET_ARCH_VARIANT: armv8-2a` (cp2a enforcement)
- KernelSU duplicate cleanup (`dispatch.c`) via `fix_ksu_dupes.sh` + `ksu_dupes.patch`

## Maintainer

Ângelo Azevedo

## Branches

| Branch | Android | Status |
|--------|---------|--------|
| `voltage-17` | 17 (cp2a) | Active |
| `voltage` | 16 (bp4a) | Production |
| `voltage-old` | 16 | Archive |

## Credits

- [kleidione](https://github.com/kleidione/device_nothing_Spacewar) — foundation (vibrator, FP, power profiles, ghost touch)
- [smrth097](https://github.com/smrth097/android_device_nothing_Spacewar) — perf/IRQ/WiFi/logging
- [crDroid](https://github.com/crdroidandroid/android_device_nothing_Spacewar) — camera configs, BT codecs, audio mixer paths
- [halogenOS](https://github.com/halogenOS/android_device_nothing_Spacewar) — brightness mapping
- [StudioKeys-Dumps](https://github.com/StudioKeys-Dumps) — NGlyphs HAL, cp2a base
- [DaViDev985](https://github.com/DaViDev985/vendor_nothing_Spacewar) — working vendor blobs
