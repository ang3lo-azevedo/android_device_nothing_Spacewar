#!/bin/sh
# Fix KernelSU duplicate definitions in dispatch.c
DISPATCH=kernel/nothing/sm7325/KernelSU/kernel/supercall/dispatch.c
[ -f "$DISPATCH" ] || exit 0

# Remove duplicate struct block between "version_full" and "ksu_manager_entry"
awk '
/ksu_manager_entry/ { skip=0 }
!skip { print }
/version_full.*string/ { skip=1 }
' "$DISPATCH" > "${DISPATCH}.tmp" && mv "${DISPATCH}.tmp" "$DISPATCH"

# Remove #define KSU_IOCTL_HOOK_TYPE line and its continuation
sed -i '/^#define KSU_IOCTL_HOOK_TYPE/{N;s/.*\n//;}' "$DISPATCH"
sed -i '/^#define KSU_IOCTL_HOOK_TYPE/d' "$DISPATCH"

# Remove static const __u32 KSU_IOCTL_HOOK_TYPE line
sed -i '/^static const __u32 KSU_IOCTL_HOOK_TYPE/d' "$DISPATCH"

# Remove first do_get_hook_type function (keep the SUSFS one)
awk '
/^static int do_get_hook_type/ { if (++count == 1) { skip=1; next } }
/^}$/ && skip { skip=0; next }
!skip { print }
' "$DISPATCH" > "${DISPATCH}.tmp" && mv "${DISPATCH}.tmp" "$DISPATCH"
