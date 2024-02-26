-include env_make

REPO ?= walkero/odysseyondocker
TAG ?= latest-gcc11
VOLUMES ?= -v "${PWD}/code":/opt/code
WORKSPACE ?= -w /opt/code
NAME ?= odysseyondocker-gcc11

.PHONY: build buildnc shell push logs clean release

default: build

build:
	docker build -t $(REPO):$(TAG) --progress plain .

buildnc:
	docker build --no-cache -t $(REPO):$(TAG) --progress plain .

shell:
	docker run -it --rm --name $(NAME) $(VOLUMES) $(WORKSPACE) $(REPO):$(TAG) /bin/bash

push:
	docker push $(REPO):$(TAG)

logs:
	docker logs $(NAME)

clean:
	-docker rm -f $(NAME)

release: buildnc push
