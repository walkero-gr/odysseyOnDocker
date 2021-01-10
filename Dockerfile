FROM walkero/amigagccondocker:ppc-amigaos-8 as adtools-image
FROM walkero/docker4amigavbcc:latest-base

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Remove from base image unused files
RUN rm -rf /opt/vbcc;

ENV APPC="/opt/ppc-amigaos"
COPY --from=adtools-image $APPC $APPC

RUN apt-get update && apt-get -y install \
    bison \
    cmake \
    cvs \
    flex \
    gperf \
    libgmp-dev \
    libisl-dev \
    libmpc-dev \
    libmpfr-dev \
    mercurial \
    pkg-config \
    ruby \
    subversion ; \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

# TODO: Add more packages needed for timberwolf compilation. These should be merged with the above
# RUN apt-get update && apt-get -y install \
#     libidl-dev; \
#     apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*;

ENV PATH="$APPC/bin:$PATH" \
    AS=$APPC/bin/ppc-amigaos-as \
    LD=$APPC/bin/ppc-amigaos-ld \
    AR=$APPC/bin/ppc-amigaos-ar \
    CC=$APPC/bin/ppc-amigaos-gcc \
    CXX=$APPC/bin/ppc-amigaos-g++ \
    RANLIB=$APPC/bin/ppc-amigaos-ranlib

RUN ln -sf $APPC/bin/ppc-amigaos-as /usr/bin/as && \
    ln -sf $APPC/bin/ppc-amigaos-ar /usr/bin/ar && \
    ln -sf $APPC/bin/ppc-amigaos-ld /usr/bin/ld && \
    ln -sf $APPC/bin/ppc-amigaos-gcc /usr/bin/gcc && \
    ln -sf $APPC/bin/ppc-amigaos-g++ /usr/bin/g++ && \
    ln -sf $APPC/bin/ppc-amigaos-ranlib /usr/bin/ranlib;

RUN mkdir -p /opt/sdk/ppc-amigaos; \
    mkdir -p /opt/code;

# Install AmigaOS 4 SDK
RUN curl -fskSL "https://www.hyperion-entertainment.biz/index.php?option=com_registration&amp;view=download&amp;format=raw&amp;file=82&amp;Itemid=82" -o /tmp/AmigaOS4-SDK.lha; \
    cd /tmp; \
    lha -xfq2 AmigaOS4-SDK.lha; \
    cd SDK_Install; \
    lha -xfq2 clib2*.lha; \
    lha -xfq2 newlib*.lha; \
    lha -xfq2 base.lha; \
    lha -xfq2 pthreads*.lha; \
    mv ./Documentation /opt/sdk/ppc-amigaos; \
    mv ./Examples /opt/sdk/ppc-amigaos; \
    mv ./Include /opt/sdk/ppc-amigaos/include; \
    mv ./newlib /opt/sdk/ppc-amigaos; \
    mv ./clib2 /opt/sdk/ppc-amigaos; \
    mv ./Local/clib2/lib/* /opt/sdk/ppc-amigaos/clib2/lib; \
    mv ./Local/newlib/lib/* /opt/sdk/ppc-amigaos/newlib/lib; \
    mv ./Local/common/include/* /opt/sdk/ppc-amigaos/include/include_h; \
    rm -rf $APPC/ppc-amigaos/SDK; \
    ln -s /opt/sdk/ppc-amigaos/ $APPC/ppc-amigaos/SDK; \
    rm -rf /tmp/*;

ENV AOS4_SDK_INC="/opt/sdk/ppc-amigaos/Include/include_h" \
    AOS4_NET_INC="/opt/sdk/ppc-amigaos/Include/netinclude" \
    AOS4_NLIB_INC="/opt/sdk/ppc-amigaos/newlib/include" \
    AOS4_CLIB_INC="/opt/sdk/ppc-amigaos/clib2/include"

# Install MUI 5.0 dev
RUN curl -fsSL "https://muidev.de/download/MUI%205.0%20-%20Release/MUI-5.0-2020R3-os4.lha" -o /tmp/MUI-5.0.lha; \
    curl -fsSL "https://muidev.de/download/MUI%205.0%20-%20Release/MUI-5.0-2020R3-os4-contrib.lha" -o /tmp/MUI-5.0-contrib.lha; \
    cd /tmp; \
    lha -xfq2 MUI-5.0.lha; \
    lha -xfq2 MUI-5.0-contrib.lha; \
    mv ./SDK/MUI /opt/sdk/MUI_5.0; \
    rm -rf /tmp/*;

ENV MUI50_INC="/opt/sdk/MUI_5.0/C/include"

# Install GL4ES SDK
# RUN curl -fsSL "https://github.com/kas1e/GL4ES-SDK/releases/download/1.1/gl4es_sdk-1.1.lha" -o /tmp/gl4es_sdk-1.1.lha; \
#     cd /tmp; \
#     lha -xfq2 gl4es_sdk-1.1.lha; \
#     mv SDK/local/common /opt/sdk/GL4ES;

# ENV GL4ES_INC="/opt/sdk/GL4ES/include"

# Install SDL SDK
RUN curl -fsSL "https://github.com/AmigaPorts/SDL/releases/download/v1.2.16-rc1-amigaos4/SDL.lha" -o /tmp/SDL.lha; \
    cd /tmp; \
    lha -xfq2 SDL.lha; \
    mv ./SDL/SDK/local/newlib /opt/sdk/SDL; \
    rm -rf /tmp/*;

ENV SDL_INC="/opt/sdk/SDL/include" \
    SDL_LIB="/opt/sdk/SDL/lib"

# Install SDL 2 SDK
RUN curl -fsSL "https://github.com/AmigaPorts/SDL/releases/download/v2.0.12-amigaos4/SDL2.lha" -o /tmp/SDL2.lha; \
    cd /tmp; \
    lha -xfq2 SDL2.lha; \
    mv ./SDL2/SDK/local/newlib /opt/sdk/SDL2; \
    rm -rf /tmp/*;

ENV SDL2_INC="/opt/sdk/SDL2/include" \
    SDL2_LIB="/opt/sdk/SDL2/lib"

# TODO: Install libCurl
# RUN curl -fsSL "http://os4depot.net/share/development/library/misc/libcurl.lha" -o /tmp/libcurl.lha; \
#     cd /tmp; \
#     lha -xfq2 libcurl.lha; \
#     mv ./SDK/Local /opt/sdk/libcurl; \
#     rm -rf /tmp/*;

# ENV LIB_CURL_INC="/opt/sdk/libcurl/common/include"
# ENV LIB_CURL_NLIB="/opt/sdk/libcurl/newlib/lib"
# ENV LIB_CURL_CLIB="/opt/sdk/libcurl/clib2/lib"

# Set PATH on amidev user
USER amidev
ARG BASHFILE=/home/amidev/.bashrc
RUN sed -i '4c\'"\nexport PATH=${PATH}\n" ${BASHFILE};

USER root
RUN chown amidev:amidev /opt -R
