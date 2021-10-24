# DashJ Merk Library for Android

##Build Instructions:
These commands do not work on Windows due to missing toolchains for Android.

###Run once:
```shell
rustup install nightly
rustup +nightly target add armv7-linux-androideabi   # for arm
rustup +nightly target add i686-linux-android        # for x86
rustup +nightly target add aarch64-linux-android     # for arm64
rustup +nightly target add x86_64-linux-android      # for x86_64
```
###followed by:
```shell
./gradlew assemble
```
# Publishing to maven central
```shell
./gradlew uploadArchives
```