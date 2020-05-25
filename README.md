[![Build Status](https://drone-gh.intercube.gr/api/badges/walkero-gr/odysseyOnDocker/status.svg)](https://drone-gh.intercube.gr/walkero-gr/odysseyOnDocker)

# odysseyOnDocker
This is a docker image with GCC compiler for cross compiling software for AmigaOS 4. It is based on Ubuntu and has everything needed (ggc compiler, SDKs, libraries) for cross compiling your applications. It's target is to be an out of box solution for compiling Odyssey browser for AmigaOS 4, but will be able to be used for other applications as well.

The purpose of this docker image is to have Odyssey browser (https://github.com/kas1e/Odyssey) compile for AmigaOS 4, and then be able other apps to be compiled as well.

## PPC development image
The **odysseyOnDocker:latest** image contains the following:

| app               | version                        | source
|-------------------|--------------------------------|-----------------------------------|
| gcc               | 8.3.0 (adtools build 8.3.0)    | https://github.com/AmigaPorts/adtools
| AmigaOS 4 SDK     | 53.30                          | http://www.hyperion-entertainment.com/
| MUI 5.x dev       | 5.0-2019R4                     | http://muidev.de/downloads
| AmiSSL SDK        | 4.5                            | https://github.com/jens-maus/amissl/releases/tag/4.5

## How to create a docker container

To create a container based on this image run in the terminal:

```bash
docker run -it --rm --name odysseyOnDocker -v "$PWD"/code:/opt/code -w /opt/code walkero/odysseyondocker:latest /bin/bash
```

If you want to use it with **docker-compose**, you can create a *docker-compose.yml* file, with the following content:

```yaml
version: '3'

services:
  odysseyondocker:
    image: 'walkero/odysseyondocker:latest'
    volumes:
      - './code:/opt/code'
```

And then you can create and get into the container by doing the following:
```bash
docker-compose up -d
docker-compose odysseyondocker exec bash
```

To compile your project you have to get into the container, inside the */opt/code/projectname* folder, which is shared with the host machine, and run the compilation.

## How to set your own include paths

The **odysseyondocker:latest** image has the following ENV variables set:

* **AS**: /opt/ppc-amigaos/bin/ppc-amigaos-as
* **LD**: /opt/ppc-amigaos/bin/ppc-amigaos-ld
* **AR**: /opt/ppc-amigaos/bin/ppc-amigaos-ar
* **CC**: /opt/ppc-amigaos/bin/ppc-amigaos-gcc
* **CXX**: /opt/ppc-amigaos/bin/ppc-amigaos-g++
* **RANLIB**: /opt/ppc-amigaos/bin/ppc-amigaos-ranlib
* **AOS4_SDK_INC**: /opt/sdk/ppc-amigaos/Include/include_h
* **AOS4_NET_INC**: /opt/sdk/ppc-amigaos/Include/netinclude
* **AOS4_NLIB_INC**: /opt/sdk/ppc-amigaos/newlib/include
* **AOS4_CLIB_INC**: /opt/sdk/ppc-amigaos/clib2/include
* **MUI50_INC**: /opt/sdk/MUI_5.0/C/include
* **AMISSL_INC**: /opt/sdk/AmiSSL/include

You can set your own paths, if you want, by using environment variables on docker execution or inside the docker-compose.yml file, like:
```bash
docker run -it --rm --name odysseyondocker -v "$PWD"/code:/opt/code -w /opt/code -e AOS4_SDK_INC="/your/folder/path" walkero/odysseyondocker:latest /bin/bash
```
docker-compose.yml
```yaml
version: '3'

services:
  odysseyondocker:
    image: 'walkero/odysseyondocker:latest'
    environment:
      AOS4_SDK_INC: "/opt/ext_sdk/SDK_install/Include/include_h"
    volumes:
      - './code:/opt/code'
      - './ext_sdk:/opt/ext_sdk'
```

### Demo code
Under the folder `code` you will find some demo scripts that can be compiled with this gcc docker installation, as found at Kas1e's great guide (http://os4coding.net/blog/kas1e/how-build-amigaos4-cross-compiler-binutils-2232-gcc-820-msys2)

## Bug reports or feature request
If you have any issues with the images or you need help on using them or you would like to request any new feature, please contact me by opening an issue at https://github.com/walkero-gr/odysseyOnDocker/issues

## Credits
The **odysseyondocker:latest** docker image is based on the following sources:
* http://os4coding.net/blog/kas1e/how-build-amigaos4-cross-compiler-binutils-2232-gcc-820-msys2
* https://github.com/AmigaPorts/adtools
* https://github.com/AmigaPorts/docker-amiga-gcc
* https://github.com/sba1/adtools
