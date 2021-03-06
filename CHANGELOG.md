# Changelog
All notable changes to this project will be documented in this file.

## odysseyOnDocker - 2021-04-14
- Improved the Dockerfile in places
- Added parameter in Makefile to pass argument about the GCC version. Now there are docker images with GCC 8, 9 and 10.
- Updated drone script to create images with different tags, based on GCC versions
- Updated SDL SDK to v1.2.16-rc2
- Updated SDL 2 SDK to v2.0.14-update1

## odysseyOnDocker - 2021-01-11
- Added my new walkero/amigagccondocker:ppc-amigaos-8 base image
- Added python on installation components
- Cleared the code that was about compiling gcc 8
## odysseyOnDocker - 2020-09-16
### Added
- Added the pthreads libs from the AmigaOS 4 SDK into the installation
- Added a SDL2 example which compiles just fine. I would like to thank everyone at OS4Coding.net for their help.

## odysseyOnDocker - 2020-09-11
### Added
- Added SDL SDK version 1.2.16 release candidate 1 for AmigaOS 4

### Changed
- Updated gcc to 8.4.0
- Updated MUI SDK to v5.0-2020R1
- Updated SDL 2 SDK to 2.0.12 stable version
- Now the image is based on walkero/docker4amigavbcc:latest-base because of common parts
- Added amidev user and group, with ID 1000

## odysseyOnDocker - 2020-06-16
### Added
- Added SDL 2 SDK version 2.0.12 release candidate 2 for AmigaOS 4

## odysseyOnDocker - 2020-06-09
### Changed
- Updated AmiSSL SDK to latest released version 4.6

## odysseyOnDocker - 2020-05-28
### Added
- Added git branch name to bash prompt

## odysseyOnDocker - 2020-05-25
### Changed
- Optimised image layers to reduce the size by almost 40%
- Added lha v1.14i because it is able to compress files in lha format, and will be useful for packaging

## odysseyOnDocker - 2020-04-05
### Changed
- Changed the version of AmiSSL SDK to the latest 4.5

## odysseyOnDocker - 2020-03-13
### Added
- AmigaOS 4 SDK 53.30 replacing the old files
- adtools from amigadev/adtools:latest docker image
- drone CI file to auto deployment after each push to the repo
- README file with information about how this image can be used
- Added MUI 5.0-2019R4 SDK
- Added AmiSSL 4.4 SDK





The format of this changelog file is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)