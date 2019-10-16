#!/bin/sh
export HWKIND=generic
# 需要先执行Android NDK提供的make_standalone_toolchain.py 生成工具链
export AR=/Users/xiaoqiang/workspace/android-ndk-arm-14/bin/arm-linux-androideabi-ar
export LD=/Users/xiaoqiang/workspace/android-ndk-arm-14/bin/arm-linux-androideabi-ld
export CC=/Users/xiaoqiang/workspace/android-ndk-arm-14/bin/arm-linux-androideabi-gcc
export CXX=/Users/xiaoqiang/workspace/android-ndk-arm-14/bin/arm-linux-androideabi-g++
export NM=/Users/xiaoqiang/workspace/android-ndk-arm-14/bin/arm-linux-androideabi-nm
export STRIP=/Users/xiaoqiang/workspace/android-ndk-arm-14/bin/arm-linux-androideabi-strip
export RANLIB=/Users/xiaoqiang/workspace/android-ndk-arm-14/bin/arm-linux-androideabi-ranlib
 make clean
CPPFLAGS="--sysroot=/Users/xiaoqiang/workspace/android-ndk-arm-14/sysroot -DANDROID_HARDWARE_$HWKIND -D__ANDROID_API__=14" \
CFLAGS="--sysroot=/Users/xiaoqiang/workspace/android-ndk-arm-14/sysroot -D__ANDROID_API__=14" \
LIBS="-L/Users/xiaoqiang/workspace/android-ndk-arm-14/sysroot/usr/lib" \
./configure --prefix=/data/local/tmp/local/Inst \
   --host=armv7-unknown-linux \
   --target=arm-linux-androideabi --with-tmpdir=/sdcard

make -j4 TARGET=ARMV7
if [ $? -ne 0 ];
then
    exit 1
else
    echo "build success!"
fi

make -j4 install DESTDIR=`pwd`/Inst


#adb push Inst/data/local /data/local/tmp/
#export VALGRIND_LIB=/data/local/tmp/local/Inst/lib/valgrind
#/data/local/tmp/local/Inst/bin/valgrind --log-file=/sdcard/leak.log --leak-check=full --undef-value-errors=no /data/local/tmp/kcg
