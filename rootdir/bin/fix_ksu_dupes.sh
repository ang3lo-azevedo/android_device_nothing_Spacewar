#!/bin/sh
# Fix KernelSU duplicate definitions using a proper patch
DISPATCH=kernel/nothing/sm7325/KernelSU/kernel/supercall/dispatch.c
PATCH=device/nothing/Spacewar/rootdir/bin/ksu_dupes.patch
[ -f "$DISPATCH" ] && [ -f "$PATCH" ] || exit 0
patch -p0 -d kernel/nothing/sm7325/KernelSU < "$PATCH" 2>/dev/null || true
