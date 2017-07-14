# based on https://github.com/gfx/docker-android-project/blob/master/Dockerfile
FROM java:8

MAINTAINER napplecomputer <suwamura.natsuhiko@zaim.co.jp>

ENV DEBIAN_FRONTEND noninteractive

# Install dependencies
RUN dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -yq libc6:i386 libstdc++6:i386 zlib1g:i386 libncurses5:i386 --no-install-recommends && \
    apt-get install -yq build-essential libtool && \
    apt-get clean

ENV ANDROID_HOME /usr/local
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH

RUN cd /usr/local/ && \
curl -L -O https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip && \
unzip sdk-tools-linux-3859397.zip && \
/usr/local/tools/bin/sdkmanager --update && yes | /usr/local/tools/bin/sdkmanager --licenses && \
/usr/local/tools/bin/sdkmanager "platform-tools" && \
/usr/local/tools/bin/sdkmanager "build-tools;25.0.2" && \
/usr/local/tools/bin/sdkmanager "platforms;android-25" && \
/usr/local/tools/bin/sdkmanager "extras;android;m2repository" && \
/usr/local/tools/bin/sdkmanager "extras;google;m2repository" && \
/usr/local/tools/bin/sdkmanager "extras;google;google_play_services" && \
/usr/local/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout-solver;1.0.2" && \
/usr/local/tools/bin/sdkmanager "extras;m2repository;com;android;support;constraint;constraint-layout;1.0.2" && \
/usr/local/tools/bin/sdkmanager "system-images;android-25;google_apis;armeabi-v7a" && \
/usr/local/tools/bin/sdkmanager "emulator" && \
rm -rf /usr/local/sdk-tools-linux-3859397.zip

# Create AVD
RUN echo no | /usr/local/tools/bin/avdmanager create avd --force -n test --abi google_apis/armeabi-v7a --package "system-images;android-25;google_apis;armeabi-v7a"

# Support Gradle
ENV TERM dumb

