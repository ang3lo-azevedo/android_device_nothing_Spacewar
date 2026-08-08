#!/bin/sh
# Fix KernelSU duplicate definitions in dispatch.c
DISPATCH=kernel/nothing/sm7325/KernelSU/kernel/supercall/dispatch.c
[ -f "$DISPATCH" ] || exit 0

# 1. Remove duplicate struct ksu_hook_type_cmd block
sed -i '/^struct ksu_hook_type_cmd {$/,/^};$/d' "$DISPATCH"

# 2. Remove KSU_IOCTL_HOOK_TYPE macro definition (2 lines with backslash)
sed -i '/^#define KSU_IOCTL_HOOK_TYPE \\$/,+1d' "$DISPATCH"
sed -i '/^#define KSU_IOCTL_HOOK_TYPE$/d' "$DISPATCH"

# 3. Remove static const __u32 KSU_IOCTL_HOOK_TYPE variable
sed -i '/^static const __u32 KSU_IOCTL_HOOK_TYPE =/d' "$DISPATCH"

# 4. Remove first do_get_hook_type (non-SUSFS version) from "// 101." to blank line before "static int do_dynamic_manager"
# Count lines: 27 lines including comment, function body, and blank line before next function
awk '
BEGIN { skip=0; count=0 }
/^\/\/ 101\. HOOK_TYPE - Get hook type$/ && count==0 { skip=1; count=1; next }
skip && /^}$/ { skip=0; next }
!skip { print }
' "$DISPATCH" > "${DISPATCH}.tmp" && mv "${DISPATCH}.tmp" "$DISPATCH"
