#APP_PROJECT_PATH := $(call my-dir)/project
#APP_PROJECT_PATH := $(call my-dir)

APP_STL := gnustl_static
APP_CPPFLAGS := -frtti -fexceptions -O3
APP_PLATFORM := android-15
APP_ABI := armeabi armeabi-v7a
APP_OPTIM := release

APP_BUILD_SCRIPT := $(call my-dir)/Android.mk
APP_MODULES      := vsfootball
