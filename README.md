# Dockerfile for Android development

## Environment

- Open JDK 8
- Android SDK 24.4.1
- Android NDK r10d
- Build Tools 23.0.3
- Android Platform 23
- System Image armv7a 23

## Usage

```
docker pull androhi/android-with-ndk
docker run -it androhi/android-with-ndk /bin/bash
```

## Using your Dockerfile

```
FROM androhi/android-with-ndk
```
