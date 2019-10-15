#!/bin/sh
export HWKIND=generic
export AR=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-ar
export LD=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-ld
export CC=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-gcc
export STRIP=$ANDROID_NDK/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-strip
make clean
CPPFLAGS="--sysroot=$ANDROID_NDK/platforms/android-14/arch-arm -DANDROID_HARDWARE_$HWKIND" \
	CFLAGS="--sysroot=$ANDROID_NDK/platforms/android-14/arch-arm " \
	LIBS="-L$ANDROID_NDK/platforms/android-14/arch-arm/usr/lib" \
   ./configure --prefix=/data/local/Inst \
   --host=armv7-unknown-linux --target=armv7-unknown-linux \
   --target=arm-linux-androideabi --with-tmpdir=/sdcard
make -j4
make -j4 install DESTDIR=`pwd`/Inst