FROM phusion/baseimage:master

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN apt-get update && apt-get -y install \
    dpkg-dev g++-8 gcc-8 libc6-dev libc-dev make \
    autoconf \
    automake \
    bison \
    cmake \
    cvs \
    flex \
    git \
    lhasa \
    libgmp-dev \
    libisl-dev \
    libmpc-dev \
    libmpfr-dev \
    libtool \
    mc \
    mercurial \
    python2.7 \
    scons \
    subversion \
    wget;

RUN mkdir -p /opt/adtools; \
    mkdir -p /opt/code; \
    mkdir -p /opt/sdk;


# Install adtools
RUN cd /opt/adtools; \
    git clone https://github.com/sba1/adtools .; \
    git submodule init; \
    git submodule update; \
    gild/bin/gild clone; \
    gild/bin/gild checkout binutils 2.23.2; \
    gild/bin/gild checkout gcc 8;

#ENV PATH="$VBCC/bin:$PATH"

# Install AmigaOS 4 SDK
# RUN curl -fkSL "http://www.hyperion-entertainment.biz/index.php?option=com_registration&amp;view=download&amp;format=raw&amp;file=82&amp;Itemid=82" -o /tmp/AmigaOS4-SDK.lha; \
#     cd /tmp; \
#     lhasa -xfq2 AmigaOS4-SDK.lha; \
#     cd SDK_Install; \
#     lhasa -xfq2 newlib*.lha; \
#     lhasa -xfq2 base.lha; \
#     mv Documentation /opt/sdk/ppc-amigaos; \
#     mv Examples /opt/sdk/ppc-amigaos; \
#     mv Include /opt/sdk/ppc-amigaos; \
#     mv newlib /opt/sdk/ppc-amigaos;

# ENV AOS4_SDK_INC="/opt/sdk/ppc-amigaos/Include/include_h"
# ENV AOS4_NET_INC="/opt/sdk/ppc-amigaos/Include/netinclude"
# ENV AOS4_NLIB_INC="/opt/sdk/ppc-amigaos/newlib/include"

# Install MUI 5.0 dev
# RUN curl -fSL "http://muidev.de/download/MUI%205.0%20-%20Release/MUI-5.0-2019R4-os4.lha" -o /tmp/MUI-5.0.lha; \
#     curl -fSL "http://muidev.de/download/MUI%205.0%20-%20Release/MUI-5.0-2019R4-os4-contrib.lha" -o /tmp/MUI-5.0-contrib.lha; \
#     cd /tmp; \
#     lhasa -xfq2 MUI-5.0.lha; \
#     lhasa -xfq2 MUI-5.0-contrib.lha; \
#     mv SDK/MUI /opt/sdk/MUI_5.0;

# ENV MUI50_INC="/opt/sdk/MUI_5.0/C/include"

# Install GL4ES SDK
# RUN curl -fSL "https://github.com/kas1e/GL4ES-SDK/releases/download/1.1/gl4es_sdk-1.1.lha" -o /tmp/gl4es_sdk-1.1.lha; \
#     cd /tmp; \
#     lhasa -xfq2 gl4es_sdk-1.1.lha; \
#     mv SDK/local/common /opt/sdk/GL4ES;

# ENV GL4ES_INC="/opt/sdk/GL4ES/include"

WORKDIR /opt/code

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*