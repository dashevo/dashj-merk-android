#!/usr/bin/env bash
# set the version to use the library
min_ver=23
ANDROID_NDK_HOME=$ANDROID_SDK_HOME/ndk
# verify before executing this that you have the proper targets installed
cd ./src/main/rust
cargo ndk +nightly-2021-03-25 --target aarch64-linux-android --android-platform ${min_ver} -- build --release
cargo ndk +nightly-2021-03-25 --target armv7-linux-androideabi --android-platform ${min_ver} -- build --release
cargo ndk +nightly-2021-03-25 --target i686-linux-android --android-platform ${min_ver} -- build --release
cargo ndk +nightly-2021-03-25 --target x86_64-linux-android --android-platform ${min_ver} -- build --release
cd ../../..

# moving libraries to the android project
jniLibs=./src/main/jniLibs
libName=libdashj_merk.so

rm -rf ${jniLibs}

mkdir ${jniLibs}
mkdir ${jniLibs}/arm64-v8a
mkdir ${jniLibs}/armeabi-v7a
mkdir ${jniLibs}/x86
mkdir ${jniLibs}/x86_64

cp ./src/main/rust/target/aarch64-linux-android/release/${libName} ${jniLibs}/arm64-v8a/${libName}
cp ./src/main/rust/target/armv7-linux-androideabi/release/${libName} ${jniLibs}/armeabi-v7a/${libName}
cp ./src/main/rust/target/i686-linux-android/release/${libName} ${jniLibs}/x86/${libName}
cp ./src/main/rust/target/x86_64-linux-android/release/${libName} ${jniLibs}/x86_64/${libName}

cp -v $ANDROID_NDK_HOME/sources/cxx-stl/llvm-libc++/libs/arm64-v8a/libc++_shared.so ${jniLibs}/arm64-v8a/
cp -v $ANDROID_NDK_HOME/sources/cxx-stl/llvm-libc++/libs/x86_64/libc++_shared.so ${jniLibs}/x86_64/
cp -v $ANDROID_NDK_HOME/sources/cxx-stl/llvm-libc++/libs/armeabi-v7a/libc++_shared.so ${jniLibs}/armeabi-v7a/
cp -v $ANDROID_NDK_HOME/sources/cxx-stl/llvm-libc++/libs/x86/libc++_shared.so ${jniLibs}/x86/