#
# Copyright (C) 2017 The Android Open Source Project
# Copyright (C) 2018 PitchBlack Recovery Project
# Copyright (C) 2018-2020 OrangeFox Recovery Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

DEVICE_PATH := device/10or/G

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 :=
TARGET_CPU_VARIANT := cortex-a53

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := cortex-a53

# Kernel
BOARD_KERNEL_CMDLINE := androidboot.hardware=qcom msm_rtb.filter=0x237 ehci-hcd.park=3 lpm_levels.sleep_disabled=1 androidboot.bootdevice=7824900.sdhci earlycon=msm_hsl_uart,0x78af000 androidboot.selinux=permissive
BOARD_KERNEL_BASE := 0x80000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_TAGS_OFFSET := 0x00000100
BOARD_RAMDISK_OFFSET := 0x01000000
TARGET_KERNEL_VERSION := 4.9
TARGET_PREBUILT_KERNEL := $(DEVICE_PATH)/Image.gz-dtb

# Assert
TARGET_OTA_ASSERT_DEVICE := G

# Partitions
BOARD_USES_METADATA_PARTITION := true

BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_PERSISTIMAGE_PARTITION_SIZE := 33554432
BOARD_CACHEIMAGE_PARTITION_SIZE := 268435456
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_USERDATAIMAGE_PARTITION_SIZE := 56563834368
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)

BOARD_SUPER_PARTITION_BLOCK_DEVICES := oem system
BOARD_SUPER_PARTITION_METADATA_DEVICE := system
BOARD_SUPER_PARTITION_OEM_DEVICE_SIZE := 268435456
BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE := 4508876800
BOARD_SUPER_PARTITION_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_OEM_DEVICE_SIZE) + $(BOARD_SUPER_PARTITION_SYSTEM_DEVICE_SIZE) )

BOARD_SUPER_PARTITION_GROUPS := 10or_g_dynpart
BOARD_10OR_G_DYNPART_SIZE := $(shell expr $(BOARD_SUPER_PARTITION_SIZE) - 4194304 )
BOARD_10OR_G_DYNPART_PARTITION_LIST := odm product system system_ext vendor

BOARD_ROOT_EXTRA_SYMLINKS := \
    /vendor/dsp:/dsp \
    /vendor/firmware_mnt:/firmware \
    /mnt/vendor/persist:/persist

SSI_PARTITIONS := product system system_ext
TREBLE_PARTITIONS := odm vendor
ALL_PARTITIONS := $(SSI_PARTITIONS) $(TREBLE_PARTITIONS)

$(foreach p, $(call to-upper, $(ALL_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_FILE_SYSTEM_TYPE := ext4) \
    $(eval TARGET_COPY_OUT_$(p) := $(call to-lower, $(p))))

# Partitions (File systems)
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4

# Partitions (reserved size)
$(foreach p, $(call to-upper, $(SSI_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_EXTFS_INODE_COUNT := -1))
$(foreach p, $(call to-upper, $(TREBLE_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_EXTFS_INODE_COUNT := 4096))

$(foreach p, $(call to-upper, $(SSI_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_PARTITION_RESERVED_SIZE := 83886080)) # 80 MB
$(foreach p, $(call to-upper, $(TREBLE_PARTITIONS)), \
    $(eval BOARD_$(p)IMAGE_PARTITION_RESERVED_SIZE := 41943040)) # 40 MB

ifneq ($(WITH_GMS),true)
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 1500000000 # 1.5 GB
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE := 300000000 # 300 MB
endif

# Platform
TARGET_BOARD_PLATFORM := msm8953
TARGET_BOARD_PLATFORM_GPU := qcom-adreno506
TARGET_BOARD_SUFFIX := _64

# Recovery
BOARD_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab.device
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_USE_EXT4 := true
BOARD_HAS_LARGE_FILESYSTEM := true

# TWRP Configuration
include $(DEVICE_PATH)/BoardConfigTWRP.mk
