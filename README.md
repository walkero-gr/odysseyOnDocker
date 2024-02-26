[![Build Status](https://drone-gh.intercube.gr/api/badges/walkero-gr/odysseyOnDocker/status.svg)](https://drone-gh.intercube.gr/walkero-gr/odysseyOnDocker)

# odysseyOnDocker
The purpose of this docker image is to have [Odyssey browser](https://github.com/kas1e/Odyssey) compile for AmigaOS 4. Odyssey code ready to be compiled with this docker image can be found at the fork [https://github.com/walkero-gr/Odyssey](https://github.com/walkero-gr/Odyssey) and a guide on how to compile it at [https://github.com/walkero-gr/Odyssey/blob/develop/BUILD_ON_DOCKER.md](https://github.com/walkero-gr/Odyssey/blob/develop/BUILD_ON_DOCKER.md).

This image is based on my amigagccondocker docker images which can be found at [https://github.com/walkero-gr/AmigaGCConDocker](https://github.com/walkero-gr/AmigaGCConDocker)

## How to create a docker container

To create a Docker container based on this image run in the terminal:

```bash
docker run -it --rm --name odysseyOnDocker-gcc11 -v ${PWD}/code:/opt/code -w /opt/code walkero/odysseyondocker:latest-gcc11 /bin/bash
```

If you want to use it with **docker-compose**, you can create a *docker-compose.yml* file, with the following content:

```yaml
version: '3'

services:
  odysseyondocker-gcc11:
    image: 'walkero/odysseyondocker:latest-gcc11'
    environment:
      ODYSSEY_INC: "/opt/code/Odyssey/odyssey-r155188-1.23_SDK/SDK"
    volumes:
      - './code:/opt/code'
```

And then you can create and get into the container by doing the following:
```bash
docker-compose up -d
docker-compose exec odysseyondocker bash
```

To compile your project you have to get into the container, inside the */opt/code/projectname* folder, which is shared with the host machine.


### amidev user
amidev user has ID 1000. Using this user inside the container helps your files to have the same permissions with the user you have on the host machine, so both sides have full access to the files. To change to amidev user inside the container you can `su amidev`. 

I recommend to use VSCode with [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension installed. You can use that extension to connect on the running GCC container. If you want automatically to set the extensions, set the user and other configuration for each container, after you attach to it select from action menu (F1) the "Remote-Containers: Open Container Configuration FIle" and add the configuration based on your preference. 

Below is my own example, with some really useful extensions:
```json
{
	"extensions": [
		"donjayamanne.githistory",
		"eamodio.gitlens",
		"EditorConfig.EditorConfig",
		"Gruntfuggly.todo-tree",
		"ms-vscode.cpptools",
		"patricklee.vsnotes",
		"prb28.amiga-assembly",
		"SanaAjani.taskrunnercode"
	],
	"workspaceFolder": "/opt/code",
	"remoteUser": "amidev"
}
```

### Demo code
Under the folder `code` you will find some demo scripts that can be compiled with this gcc docker installation, as found at [Kas1e's great guide](http://os4coding.net/blog/kas1e/how-build-amigaos4-cross-compiler-binutils-2232-gcc-820-msys2)

## Bug reports or feature request
If you have any issues with the images or you need help on using them or you would like to request any new feature, please contact me by opening an issue at [https://github.com/walkero-gr/odysseyOnDocker/issues](https://github.com/walkero-gr/odysseyOnDocker/issues)

## Credits
This docker image is based on the following sources:
* http://os4coding.net/blog/kas1e/how-build-amigaos4-cross-compiler-binutils-2232-gcc-820-msys2
* https://github.com/AmigaPorts/adtools
* https://github.com/AmigaPorts/docker-amiga-gcc
* https://github.com/sba1/adtools
