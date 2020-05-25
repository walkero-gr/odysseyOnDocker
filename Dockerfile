FROM amigadev/adtools:latest as adtools-image

FROM phusion/baseimage:master

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

COPY --from=adtools-image /opt/ppc-amigaos /opt/ppc-amigaos

ENV PATH ${PATH}:/opt/ppc-amigaos/bin

# RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 379CE192D401AB61; \
#     echo "deb http://dl.bintray.com/sba1/adtools-deb /" | tee -a /etc/apt/sources.list;

RUN apt-get update && apt-get -y install \
    # dpkg-dev g++-8 gcc-8 libc6-dev libc-dev \ 
    make \
    # autoconf \
    # automake \
    # bison \
    # build-essential \
    cmake \
    cvs \
    # flex \
    git \
    lhasa \
    libgmp-dev \
    libisl-dev \
    # libmpfr6 \
    libmpc-dev \
    libmpfr-dev \
    # libtool \
    mc \
    mercurial \
    # python2.7 \
    # scons \
    subversion \
    wget ; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;


ENV AS=/opt/ppc-amigaos/bin/ppc-amigaos-as \
    LD=/opt/ppc-amigaos/bin/ppc-amigaos-ld \
    AR=/opt/ppc-amigaos/bin/ppc-amigaos-ar \
    CC=/opt/ppc-amigaos/bin/ppc-amigaos-gcc \
    CXX=/opt/ppc-amigaos/bin/ppc-amigaos-g++ \
    RANLIB=/opt/ppc-amigaos/bin/ppc-amigaos-ranlib

RUN ln -sf /opt/ppc-amigaos/bin/ppc-amigaos-as /usr/bin/as && \
    ln -sf /opt/ppc-amigaos/bin/ppc-amigaos-ar /usr/bin/ar && \
    ln -sf /opt/ppc-amigaos/bin/ppc-amigaos-ld /usr/bin/ld && \
    ln -sf /opt/ppc-amigaos/bin/ppc-amigaos-gcc /usr/bin/gcc && \
    ln -sf /opt/ppc-amigaos/bin/ppc-amigaos-g++ /usr/bin/g++ && \
    ln -sf /opt/ppc-amigaos/bin/ppc-amigaos-ranlib /usr/bin/ranlib;

# RUN apt update && apt install \
#         python-pip \
#         python3-pip; \
#     pip install argcomplete; \
#     pip3 install argcomplete; 

RUN mkdir -p /opt/sdk/ppc-amigaos; \
    mkdir -p /opt/code;

# Compile adtools
# RUN cd /opt/adtools; \
#     git config --global user.email "walkero@gmail.com"; \
#     git config --global user.name "George Sokianos"; \
#     git clone https://github.com/sba1/adtools .; \
#     git submodule init; \
#     git submodule update;

# RUN gild/bin/gild clone; \
#     gild/bin/gild checkout binutils 2.23.2; \
#     gild/bin/gild checkout gcc 8;

# RUN make -C native-build gcc-cross CROSS_PREFIX=/usr/local/amiga -j3

#ENV PATH="$VBCC/bin:$PATH"

# Install AmigaOS 4 SDK
RUN curl -fkSL "https://www.hyperion-entertainment.biz/index.php?option=com_registration&amp;view=download&amp;format=raw&amp;file=82&amp;Itemid=82" -o /tmp/AmigaOS4-SDK.lha; \
    cd /tmp; \
    lhasa -xfq2 AmigaOS4-SDK.lha; \
    cd SDK_Install; \
    lhasa -xfq2 clib2*.lha; \
    lhasa -xfq2 newlib*.lha; \
    lhasa -xfq2 base.lha; \
    mv Documentation /opt/sdk/ppc-amigaos; \
    mv Examples /opt/sdk/ppc-amigaos; \
    mv Include /opt/sdk/ppc-amigaos; \
    mv newlib /opt/sdk/ppc-amigaos; \
    mv clib2 /opt/sdk/ppc-amigaos; \
    rm -rf /opt/ppc-amigaos/ppc-amigaos/SDK; \
    ln -s /opt/sdk/ppc-amigaos/ /opt/ppc-amigaos/ppc-amigaos/SDK; \
    rm -rf /tmp/*;

ENV AOS4_SDK_INC="/opt/sdk/ppc-amigaos/Include/include_h"
ENV AOS4_NET_INC="/opt/sdk/ppc-amigaos/Include/netinclude"
ENV AOS4_NLIB_INC="/opt/sdk/ppc-amigaos/newlib/include"
ENV AOS4_CLIB_INC="/opt/sdk/ppc-amigaos/clib2/include"

# Install MUI 5.0 dev
RUN curl -fSL "https://muidev.de/download/MUI%205.0%20-%20Release/MUI-5.0-2019R4-os4.lha" -o /tmp/MUI-5.0.lha; \
    curl -fSL "https://muidev.de/download/MUI%205.0%20-%20Release/MUI-5.0-2019R4-os4-contrib.lha" -o /tmp/MUI-5.0-contrib.lha; \
    cd /tmp; \
    lhasa -xfq2 MUI-5.0.lha; \
    lhasa -xfq2 MUI-5.0-contrib.lha; \
    mv SDK/MUI /opt/sdk/MUI_5.0; \
    rm -rf /tmp/*;

ENV MUI50_INC="/opt/sdk/MUI_5.0/C/include"

# Install AMISSL SDK
RUN curl -fSL "https://github.com/jens-maus/amissl/releases/download/4.4/AmiSSL-4.4.lha" -o /tmp/AmiSSL.lha; \
    cd /tmp; \
    lhasa -xfq2 AmiSSL.lha; \
    mv AmiSSL/Developer /opt/sdk/AmiSSL; \
    rm -rf /tmp/*;

ENV AMISSL_INC="/opt/sdk/AmiSSL/include"

# Install GL4ES SDK
# RUN curl -fSL "https://github.com/kas1e/GL4ES-SDK/releases/download/1.1/gl4es_sdk-1.1.lha" -o /tmp/gl4es_sdk-1.1.lha; \
#     cd /tmp; \
#     lhasa -xfq2 gl4es_sdk-1.1.lha; \
#     mv SDK/local/common /opt/sdk/GL4ES;

# ENV GL4ES_INC="/opt/sdk/GL4ES/include"

WORKDIR /opt/code

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*