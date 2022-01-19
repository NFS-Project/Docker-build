FROM ubuntu:21.10

LABEL maintainer="NFS86 <jarbull86@gmail.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -yqq update
RUN apt-get -yqq upgrade
RUN apt-get install  -yqq bison build-essential curl flex g++-multilib gcc-multilib git gnupg gperf imagemagick lib32ncurses5-dev lib32readline-dev lib32z1-dev liblz4-tool libncurses5 libncurses5-dev libsdl1.2-dev libssl-dev libxml2 libxml2-utils lzop pngcrush rsync schedtool squashfs-tools xsltproc zip zlib1g-dev iputils-ping ccache
RUN apt-get install tzdata
RUN apt-mark hold tzdata
RUN ln -snf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
RUN echo Asia/Jakarta > /etc/timezone
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"
RUN apt install sudo git -yqq
RUN python3 -m pip  install networkx
RUN ln -sf /usr/bin/python3 /usr/bin/python
RUN git config --global user.name NFS86
RUN git config --global user.email jarbull86@gmail.com
RUN git clone https://github.com/akhilnarang/scripts
RUN bash scripts/setup/android_build_env.sh
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo && chmod a+x ~/bin/repo
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf *
RUN for t in gcc g++ cc c++ clang clang++; do ln -vs /usr/bin/ccache /usr/local/bin/$t; done
RUN rm -rf /var/lib/dpkg/info/*.postinst
RUN dpkg --configure -a
