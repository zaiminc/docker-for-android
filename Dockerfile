# based on https://github.com/gfx/docker-android-project/blob/master/Dockerfile
FROM java:8

MAINTAINER Takahiro Shimokawa <takahiro.1828@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -yq libc6:i386 libstdc++6:i386 zlib1g:i386 libncurses5:i386 --no-install-recommends && \
    apt-get install -yq build-essential libtool && \
    apt-get clean

# Download and untar SDK
ENV ANDROID_SDK_URL http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz
RUN curl -L "${ANDROID_SDK_URL}" | tar --no-same-owner -xz -C /usr/local
ENV ANDROID_HOME /usr/local/android-sdk-linux
ENV ANDROID_SDK /usr/local/android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

# Download and execute NDK
ENV ANDROID_NDK_DIR android-ndk-r10d
ENV ANDROID_NDK_URL https://dl.google.com/android/ndk/${ANDROID_NDK_DIR}-linux-x86_64.bin
RUN wget "${ANDROID_NDK_URL}"
RUN chmod a+x ${ANDROID_NDK_DIR}-linux-x86_64.bin
RUN ./${ANDROID_NDK_DIR}-linux-x86_64.bin
RUN mv ./${ANDROID_NDK_DIR} /usr/local/${ANDROID_NDK_DIR}
ENV ANDROID_NDK_HOME /usr/local/${ANDROID_NDK_DIR}
ENV PATH ${ANDROID_NDK_HOME}:$PATH

# Install Android SDK components
# License Id: android-sdk-license-ed0d0a5b
ENV ANDROID_COMPONENTS platform-tools,build-tools-23.0.3,android-23
# License Id: android-sdk-license-5be86d5
ENV GOOGLE_COMPONENTS extra-android-m2repository,extra-google-m2repository

RUN echo y | android update sdk --no-ui --all --filter "${ANDROID_COMPONENTS}" ; \
    echo y | android update sdk --no-ui --all --filter "${GOOGLE_COMPONENTS}"

# Support Gradle
ENV TERM dumb

