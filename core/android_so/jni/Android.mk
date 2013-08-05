LOCAL_PATH := $(call my-dir)
LOCAL_ARM_MODE := arm

include $(CLEAR_VARS)

LOCAL_MODULE    := vsfootball

AM_CFLAGS := -march=armv7-a -mfpu=vfp
AM_CCASFLAGS := -march=armv7-a -mfpu=vfp

NDK_VER := android-ndk-r8b
SDK9_ROOT   := platforms/android-9/arch-arm
SDK9_INC    := $(SDK9_ROOT)/usr/include

COREINC := /Users/rdasxy/Documents/proj/VsFootball/core/vsf

INC         := -I$(SDK9_INC) -I$(COREINC)

TARGET_ARCH_ABI := armeabi-v7a armeabi
OPTS            := -O3 -mfpu=vfp
#OPTS           := -O3 -mfpu=neon
LOCAL_CFLAGS += -O3
LOCAL_CFLAGS += -mfpu=vfp -Werror
#LOCAL_CFLAGS += -mfpu=neon
LOCAL_CFLAGS += -mfloat-abi=softfp
LOCAL_CFLAGS += -fstrict-aliasing -DANDROID -DANDROID_TILE_BASED_DECODE -DENABLE_ANDROID_NULL_CONVERT

LOCAL_CPPFLAGS += $(OPTS) $(INC) -DHAVE_SYS_TYPES_H -DHAVE_MMAP=0 -D__ANDROID__ -DNO_MALLINFO=1 -DUSING_IMP_GPU=1
LOCAL_CPPFLAGS += -DDO_LOGGING=1 -Wno-psabi
#LOCAL_CPPFLAGS += -DIMAGE_LOGGING=1
LOCAL_CPPFLAGS += -DDO_TIMING_TREE=1

LOCAL_LDLIBS += -L$(NDK_ROOT)/sources/cxx-stl/gnu-libstdc++/4.6/libs/armeabi
LOCAL_LDLIBS += -L$(SDK9_ROOT)/usr/lib -llog -landroid -lgnustl_static -lsupc++

JNI_SRC := jni_interface.cpp
VSFOOTBALL_SRC := \
    ../../vsf/VsfMain.cpp \
    ../../vsf/Threads.cpp
LOCAL_SRC_FILES := $(JNI_SRC) $(VSFOOTBALL_SRC)

include $(BUILD_SHARED_LIBRARY)
