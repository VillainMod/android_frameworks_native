# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# we have the common sources, plus some device-specific stuff
sources := \
    Binder.cpp \
    BpBinder.cpp \
    IInterface.cpp \
    IMemory.cpp \
    IPCThreadState.cpp \
    IPermissionController.cpp \
    IServiceManager.cpp \
    MemoryDealer.cpp \
    MemoryBase.cpp \
    MemoryHeapBase.cpp \
    Parcel.cpp \
    PermissionCache.cpp \
    ProcessState.cpp \
    Static.cpp

ifeq ($(BOARD_NEEDS_MEMORYHEAPPMEM),true)
sources += \
    MemoryHeapPmem.cpp
endif

ifeq ($(TARGET_USES_ION),true)
    sources += MemoryHeapIon.cpp
endif

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)
LOCAL_LDLIBS += -lpthread
LOCAL_MODULE := libbinder
LOCAL_SHARED_LIBRARIES := liblog libcutils libutils

ifeq ($(EXYNOS4_ENHANCEMENTS), true)
LOCAL_SHARED_LIBRARIES += libion
LOCAL_SHARED_LIBRARIES += libsamsungion
LOCAL_CFLAGS += -DUSE_SAMSUNG_V4L2_ION -DEXYNOS4_ENHANCEMENTS
sources += MemoryHeapBaseIon.cpp
LOCAL_C_INCLUDES := $(TARGET_HAL_PATH)/include
endif

LOCAL_SRC_FILES := $(sources)
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_LDLIBS += -lpthread
LOCAL_MODULE := libbinder
LOCAL_SRC_FILES := $(sources)
include $(BUILD_STATIC_LIBRARY)
