#!/bin/sh
# Fix KernelSU duplicate definitions in dispatch.c
DISPATCH=kernel/nothing/sm7325/KernelSU/kernel/supercall/dispatch.c
[ -f "$DISPATCH" ] || exit 0

# Remove duplicate struct ksu_hook_type_cmd block
sed -i '/^struct ksu_hook_type_cmd {/,/^};$/d' "$DISPATCH"

# Remove duplicate KSU_IOCTL_HOOK_TYPE defines  
sed -i '/^#define KSU_IOCTL_HOOK_TYPE/d' "$DISPATCH"
sed -i '/^static const __u32 KSU_IOCTL_HOOK_TYPE/d' "$DISPATCH"

# Remove duplicate do_get_hook_type function
sed -i '/^static int do_get_hook_type/,/^}$/d' "$DISPATCH"
