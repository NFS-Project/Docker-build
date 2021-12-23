FROM ubuntu:focal

LABEL maintainer="NFS86 <jarbull86@gmail.com>"

ENV DEBIAN_FRONTEND noninteractive
ENV LANG=C.UTF-8
ENV JAVA_OPTS=" -Xmx7G "
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV USE_CCACHE=1
ENV HOME=/root
WORKDIR /tmp

RUN apt-get -yqq update
RUN apt-get -yqq upgrade
RUN apt-get install  -yqq sudo tzdata locales python-is-python3 pigz tar rsync rclone aria2 ccache curl wget zip unzip lzip lzop zlib1g-dev xzdec xz-utils pixz p7zip-full p7zip-rar zstd libzstd-dev lib32z1-dev ffmpeg maven nodejs ca-certificates-java python-is-python3 pigz tar rsync rclone aria2 libncurses5 adb autoconf automake axel bc bison build-essential ccache clang cmake curl expat fastboot flex g++ g++-multilib gawk gcc gcc-multilib git gnupg gperf htop imagemagick locales libncurses5 lib32ncurses5-dev lib32z1-dev libtinfo5 libc6-dev libcap-dev libexpat1-dev libgmp-dev '^liblz4-.*' '^liblzma.*' libmpc-dev libmpfr-dev libncurses5-dev libsdl1.2-dev libssl-dev libtool libxml-simple-perl libxml2 libxml2-utils lsb-core lzip '^lzma.*' lzop maven nano ncftp ncurses-dev openssh-server patch patchelf pkg-config pngcrush pngquant python2.7 python-all-dev python-is-python3 re2c rclone rsync schedtool squashfs-tools subversion sudo tar texinfo tmate tzdata unzip w3m wget xsltproc zip zlib1g-dev zram-config zstd axel flex bison ncurses-dev texinfo gcc gperf patch libtool automake g++ libncurses5-dev gawk subversion expat libexpat1-dev python-all-dev binutils-dev bc libcap-dev autoconf libgmp-dev build-essential pkg-config libmpc-dev libmpfr-dev autopoint gettext txt2man liblzma-dev libssl-dev libz-dev mercurial wget tar gcc-10 g++-10 cmake ninja-build zstd lz4 liblz4-tool liblz4-dev lzma --fix-broken --fix-missing
RUN apt-get install tzdata
RUN apt-mark hold tzdata
RUN echo 'en_GB.UTF-8 UTF-8' > /etc/locale.gen
RUN /usr/sbin/locale-gen
RUN ln -snf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
RUN echo Asia/Jakarta > /etc/timezone
RUN apt install sudo git -yqq
RUN git config --global user.name NFS86
RUN git config --global user.email jarbull86@gmail.com
RUN git clone https://github.com/akhilnarang/scripts /tmp/scripts
WORKDIR /tmp/scripts
RUN bash setup/android_build_env.sh

RUN git clone https://github.com/I-n-o-k/android_tools /tmp/anu
WORKDIR /tmp/anu
RUN bash setup.sh
RUN apt-get -yqq update --fix-missing
WORKDIR /tmp

VOLUME ["/tmp/rom", "/tmp/ccache"]
