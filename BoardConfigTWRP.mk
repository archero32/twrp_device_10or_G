#
# Copyright (C) 2022 The Android Open Source Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Brightness
TW_BRIGHTNESS_PATH := "/sys/class/leds/lcd-backlight/brightness"
TW_DEFAULT_BRIGHTNESS := 155
TW_MAX_BRIGHTNESS := 255

# Display
TW_SCREEN_BLANK_ON_BOOT := true

# Encryption
TW_INCLUDE_CRYPTO := true
TW_INCLUDE_RESETPROP := true
TW_USE_FSCRYPT_POLICY := 1
BOARD_USES_QCOM_FBE_DECRYPTION := true
PLATFORM_VERSION := 16.1.0
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH := 2127-12-31
PRODUCT_ENFORCE_VINTF_MANIFEST := true
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)

# Filesystem tools
TW_INCLUDE_FUSE_NTFS := true
TW_INCLUDE_NTFS_3G := true
TW_INCLUDE_FUSE_EXFAT := true

# Logcat
TARGET_USES_LOGD := true
TWRP_INCLUDE_LOGCAT := true

# Storage
RECOVERY_SDCARD_ON_DATA := true

# Time
TARGET_RECOVERY_QCOM_RTC_FIX := true

# Treble
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_VNDK_VERSION := current

# TWRP Configuration
BOARD_SUPPRESS_SECURE_ERASE := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
AB_OTA_UPDATER := false

# UI
TW_EXTRA_LANGUAGES := true
TW_THEME := portrait_hdpi
TW_INPUT_BLACKLIST := "hbtp_vm"

# Vibrator
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
