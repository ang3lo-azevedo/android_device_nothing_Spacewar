# SPDX-License-Identifier: Apache-2.0
# Copyright (C) 2020-2021 Qualcomm Technologies, Inc.
# Copyright (C) 2009-2019 The Linux Foundation

rev=$(cat /sys/devices/soc0/revision)
ddr_type=$(od -An -tx /proc/device-tree/memory/ddr_device_type)
ddr_type4="07"
ddr_type5="08"

# ---- Core control ----

# Gold (cpu4-6)
echo 1 0 0 > /sys/devices/system/cpu/cpu4/core_ctl/not_preferred
echo 2     > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
echo 60    > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
echo 30    > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
echo 100   > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
echo 3     > /sys/devices/system/cpu/cpu4/core_ctl/task_thres

# Prime (cpu7)
echo 0   > /sys/devices/system/cpu/cpu7/core_ctl/min_cpus
echo 60  > /sys/devices/system/cpu/cpu7/core_ctl/busy_up_thres
echo 30  > /sys/devices/system/cpu/cpu7/core_ctl/busy_down_thres
echo 100 > /sys/devices/system/cpu/cpu7/core_ctl/offline_delay_ms
echo 1   > /sys/devices/system/cpu/cpu7/core_ctl/task_thres
echo 1   > /sys/devices/system/cpu/cpu7/core_ctl/nr_prev_assist_thresh
echo 0   > /sys/devices/system/cpu/cpu0/core_ctl/enable

# ---- Scheduler ----

echo 71 95    > /proc/sys/kernel/sched_upmigrate
echo 65 85    > /proc/sys/kernel/sched_downmigrate
echo 100      > /proc/sys/kernel/sched_group_upmigrate
echo 85       > /proc/sys/kernel/sched_group_downmigrate
echo 1        > /proc/sys/kernel/sched_walt_rotate_big_tasks
echo 112      > /proc/sys/kernel/sched_coloc_busy_hysteresis_enable_cpus
echo 51       > /proc/sys/kernel/sched_min_task_util_for_boost
echo 35       > /proc/sys/kernel/sched_min_task_util_for_colocation
echo 20000000 > /proc/sys/kernel/sched_task_unfilter_period
echo 1        > /proc/sys/kernel/sched_conservative_pl

# ---- cpuset ----

echo 0-1 > /dev/cpuset/background/cpus
echo 0-2 > /dev/cpuset/system-background/cpus
echo 0-3 > /dev/cpuset/restricted/cpus
echo 0-7 > /dev/cpuset/foreground/cpus

# ---- CPU governor: Silver (policy0) ----

echo schedutil > /sys/devices/system/cpu/cpufreq/policy0/scaling_governor
echo 0         > /sys/devices/system/cpu/cpufreq/policy0/schedutil/up_rate_limit_us
echo 0         > /sys/devices/system/cpu/cpufreq/policy0/schedutil/down_rate_limit_us
echo 1152000   > /sys/devices/system/cpu/cpufreq/policy0/schedutil/hispeed_freq
echo 691200    > /sys/devices/system/cpu/cpufreq/policy0/schedutil/rtg_boost_freq
echo 691200    > /sys/devices/system/cpu/cpufreq/policy0/scaling_min_freq
echo 1         > /sys/devices/system/cpu/cpufreq/policy0/schedutil/pl

# ---- Input boost ----

echo "0:1324800" > /sys/devices/system/cpu/cpu_boost/input_boost_freq
echo 200          > /sys/devices/system/cpu/cpu_boost/input_boost_ms

# ---- CPU governor: Gold (policy4) ----

echo schedutil > /sys/devices/system/cpu/cpufreq/policy4/scaling_governor
echo 0         > /sys/devices/system/cpu/cpufreq/policy4/schedutil/up_rate_limit_us
echo 0         > /sys/devices/system/cpu/cpufreq/policy4/schedutil/down_rate_limit_us
echo 1228800   > /sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_freq
echo 85        > /sys/devices/system/cpu/cpufreq/policy4/schedutil/hispeed_load
echo -6        > /sys/devices/system/cpu/cpu4/sched_load_boost
echo -6        > /sys/devices/system/cpu/cpu5/sched_load_boost
echo -6        > /sys/devices/system/cpu/cpu6/sched_load_boost
echo 0         > /sys/devices/system/cpu/cpufreq/policy4/schedutil/rtg_boost_freq
echo 691200    > /sys/devices/system/cpu/cpufreq/policy4/scaling_min_freq
echo 1         > /sys/devices/system/cpu/cpufreq/policy4/schedutil/pl

# ---- CPU governor: Prime (policy7) ----

echo schedutil > /sys/devices/system/cpu/cpufreq/policy7/scaling_governor
echo 0         > /sys/devices/system/cpu/cpufreq/policy7/schedutil/up_rate_limit_us
echo 0         > /sys/devices/system/cpu/cpufreq/policy7/schedutil/down_rate_limit_us
echo 1324800   > /sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_freq
echo 85        > /sys/devices/system/cpu/cpufreq/policy7/schedutil/hispeed_load
echo -6        > /sys/devices/system/cpu/cpu7/sched_load_boost
echo 0         > /sys/devices/system/cpu/cpufreq/policy7/schedutil/rtg_boost_freq
echo 806400    > /sys/devices/system/cpu/cpufreq/policy7/scaling_min_freq
echo 1         > /sys/devices/system/cpu/cpufreq/policy7/schedutil/pl

# ---- RIMPS L3 DCVS ----

for c0 in /sys/devices/system/cpu/memlat/c0_memlat/cpu0-cpu-l3-lat; do
    cat $c0/available_frequencies | cut -d " " -f 1 > $c0/min_freq
    echo 400 > $c0/ratio_ceil
    echo 3   > $c0/sample_ms
done

for c4 in /sys/devices/system/cpu/memlat/c4_memlat/cpu4-cpu-l3-lat; do
    cat $c4/available_frequencies | cut -d " " -f 1 > $c4/min_freq
    echo 4000  > $c4/ratio_ceil
    echo 3     > $c4/sample_ms
    echo 60    > $c4/l2wb_pct
    echo 25000 > $c4/l2wb_filter
done

for c7 in /sys/devices/system/cpu/memlat/c7_memlat/cpu7-cpu-l3-lat; do
    cat $c7/available_frequencies | cut -d " " -f 1 > $c7/min_freq
    echo 20000 > $c7/ratio_ceil
    echo 3     > $c7/sample_ms
    echo 60    > $c7/l2wb_pct
    echo 25000 > $c7/l2wb_filter
done

# ---- Bus DCVS ----

for device in /sys/devices/platform/soc; do

    for cpubw in $device/*cpu-cpu-llcc-bw/devfreq/*cpu-cpu-llcc-bw; do
        cat $cpubw/available_frequencies | cut -d " " -f 1 > $cpubw/min_freq
        echo "2288 4577 7110 9155 12298 14236 15258" > $cpubw/bw_hwmon/mbps_zones
        echo 4    > $cpubw/bw_hwmon/sample_ms
        echo 68   > $cpubw/bw_hwmon/io_percent
        echo 20   > $cpubw/bw_hwmon/hist_memory
        echo 0    > $cpubw/bw_hwmon/hyst_length
        echo 80   > $cpubw/bw_hwmon/down_thres
        echo 0    > $cpubw/bw_hwmon/guard_band_mbps
        echo 250  > $cpubw/bw_hwmon/up_scale
        echo 1600 > $cpubw/bw_hwmon/idle_mbps
        echo 40   > $cpubw/polling_interval
    done

    for llccbw in $device/*cpu-llcc-ddr-bw/devfreq/*cpu-llcc-ddr-bw; do
        cat $llccbw/available_frequencies | cut -d " " -f 1 > $llccbw/min_freq
        if [ ${ddr_type:4:2} == $ddr_type4 ]; then
            echo "1144 1720 2086 2929 3879 5931 6515 8136" > $llccbw/bw_hwmon/mbps_zones
        elif [ ${ddr_type:4:2} == $ddr_type5 ]; then
            echo "1144 1720 2086 2929 3879 5931 6515 7980 12191" > $llccbw/bw_hwmon/mbps_zones
        fi
        echo 4    > $llccbw/bw_hwmon/sample_ms
        echo 68   > $llccbw/bw_hwmon/io_percent
        echo 20   > $llccbw/bw_hwmon/hist_memory
        echo 0    > $llccbw/bw_hwmon/hyst_length
        echo 80   > $llccbw/bw_hwmon/down_thres
        echo 0    > $llccbw/bw_hwmon/guard_band_mbps
        echo 250  > $llccbw/bw_hwmon/up_scale
        echo 1600 > $llccbw/bw_hwmon/idle_mbps
        echo 48   > $llccbw/polling_interval
    done

    for l3bw in $device/*snoop-l3-bw/devfreq/*snoop-l3-bw; do
        cat $l3bw/available_frequencies | cut -d " " -f 1 > $l3bw/min_freq
        echo 4    > $l3bw/bw_hwmon/sample_ms
        echo 10   > $l3bw/bw_hwmon/io_percent
        echo 20   > $l3bw/bw_hwmon/hist_memory
        echo 10   > $l3bw/bw_hwmon/hyst_length
        echo 0    > $l3bw/bw_hwmon/down_thres
        echo 0    > $l3bw/bw_hwmon/guard_band_mbps
        echo 0    > $l3bw/bw_hwmon/up_scale
        echo 1600 > $l3bw/bw_hwmon/idle_mbps
        echo 9155 > $l3bw/max_freq
        echo 40   > $l3bw/polling_interval
    done

    for memlat in $device/*lat/devfreq/*lat; do
        cat $memlat/available_frequencies | cut -d " " -f 1 > $memlat/min_freq
        echo 8   > $memlat/polling_interval
        echo 400 > $memlat/mem_latency/ratio_ceil
    done

    for latfloor in $device/*cpu0-cpu*latfloor/devfreq/*cpu0-cpu*latfloor; do
        cat $latfloor/available_frequencies | cut -d " " -f 1 > $latfloor/min_freq
        echo 8 > $latfloor/polling_interval
    done

    for latfloor in $device/*cpu4-cpu*latfloor/devfreq/*cpu4-cpu*latfloor; do
        cat $latfloor/available_frequencies | cut -d " " -f 1 > $latfloor/min_freq
        echo 8 > $latfloor/polling_interval
    done

    for latfloor in $device/*cpu7-cpu*latfloor/devfreq/*cpu7-cpu*latfloor; do
        cat $latfloor/available_frequencies | cut -d " " -f 1 > $latfloor/min_freq
        echo 8     > $latfloor/polling_interval
        echo 25000 > $latfloor/mem_latency/ratio_ceil
    done

    for qoslat in $device/*qoslat/devfreq/*qoslat; do
        echo 50 > $qoslat/mem_latency/ratio_ceil
    done

done

# ---- Sleep ----

echo deep > /sys/power/mem_sleep

# ---- Memory ----

configure_zram_parameters() {
    MemTotalStr=$(cat /proc/meminfo | grep MemTotal)
    MemTotal=${MemTotalStr:16:8}

    let RamSizeGB="( $MemTotal / 1048576 ) + 1"
    diskSizeUnit=M
    if [ $RamSizeGB -le 2 ]; then
        let zRamSizeMB="( $RamSizeGB * 1024 ) * 3 / 4"
    else
        let zRamSizeMB="( $RamSizeGB * 1024 ) / 2"
    fi
    [ $zRamSizeMB -gt 2048 ] && let zRamSizeMB=2048

    echo lz4kd > /sys/block/zram0/comp_algorithm

    if [ -f /sys/block/zram0/disksize ]; then
        [ -f /sys/block/zram0/use_dedup ] && echo 1 > /sys/block/zram0/use_dedup
        echo "$zRamSizeMB""$diskSizeUnit" > /sys/block/zram0/disksize
        [ -e /sys/kernel/slab/zs_handle ] && echo 0 > /sys/kernel/slab/zs_handle/store_user
        [ -e /sys/kernel/slab/zspage ]    && echo 0 > /sys/kernel/slab/zspage/store_user
        mkswap /dev/block/zram0
        swapon /dev/block/zram0 -p 32758
    fi
}

configure_read_ahead_kb_values() {
    dmpts=$(ls /sys/block/*/queue/read_ahead_kb | grep -e dm -e mmc)
    ra_kb=128

    [ -f /sys/block/mmcblk0/bdi/read_ahead_kb ]     && echo $ra_kb > /sys/block/mmcblk0/bdi/read_ahead_kb
    [ -f /sys/block/mmcblk0rpmb/bdi/read_ahead_kb ] && echo $ra_kb > /sys/block/mmcblk0rpmb/bdi/read_ahead_kb
    for dm in $dmpts; do echo $ra_kb > $dm; done
}

configure_zram_parameters
configure_read_ahead_kb_values

echo 60 > /proc/sys/vm/swappiness
echo 1  > /proc/sys/vm/watermark_scale_factor

MemTotalStr=$(cat /proc/meminfo | grep MemTotal)
MemTotal=${MemTotalStr:16:8}
[ $MemTotal -le 8388608 ] && echo 0 > /proc/sys/vm/watermark_boost_factor

echo 1 > /proc/sys/vm/kswapd_threads

setprop vendor.post_boot.parsed 1
