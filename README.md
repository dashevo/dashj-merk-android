# DashJ Merk Library for Android

##Build Instructions:
These commands do not work on Windows due to missing toolchains for Android.

Run once:
```shell
rustup +nightly-2021-03-25 target add armv7-linux-androideabi   # for arm
rustup +nightly-2021-03-25 target add i686-linux-android        # for x86
rustup +nightly-2021-03-25 target add aarch64-linux-android     # for arm64
rustup +nightly-2021-03-25 target add x86_64-linux-android      # for x86_64
```
followed by
```shell
./gradlew assemble
```
# Publishing to maven central
```shell
./gradlew uploadArchives
```