FROM walkero/amigagccondocker:os4-gcc11-exp as adtools-image

LABEL maintainer="Georgios Sokianos <walkero@gmail.com>"

ENV SDK_PATH="/opt/ppc-amigaos/ppc-amigaos/SDK"

RUN mv ${SDK_PATH}/include/include_h/openssl ${SDK_PATH}/include/include_h/openssl_amissl; \
    mv ${SDK_PATH}/local ${SDK_PATH}/local_disabled

WORKDIR /opt/code/Odyssey
