NAME = adguard-home-raspi

ifdef DOCKER_HUB_USERNAME
IMAGE_NAME = ${DOCKER_HUB_USERNAME}/${NAME}
else
IMAGE_NAME = ${NAME}
endif

FILENAME = AdGuardHome.tar.gz

test:
	@echo ${IMAGE_NAME}

build: get
	docker build -t ${IMAGE_NAME}:latest .

get:

ifeq (,$(wildcard ./${FILENAME}))
	curl -s https://api.github.com/repos/AdguardTeam/AdGuardHome/releases/latest \
	| grep "browser_download_url.*arm.tar.gz" \
	| cut -d : -f 2,3 \
	| tr -d \" \
	| wget -O ${FILENAME} -qi -

	tar xzvf ${FILENAME}
endif

fresh_build:
	docker build --no-cache t ${IMAGE_NAME}:latest .

run: build
	docker run --rm -ti ${IMAGE_NAME}:latest

shell: build
	docker run --rm -ti ${IMAGE_NAME}:latest bash

attach:
	docker exec -ti `docker ps | grep '${IMAGE_NAME}:latest' | awk '{ print $$1 }'` bash

push: build
	docker tag ${IMAGE_NAME}:latest ${IMAGE_NAME}:latest && docker push ${IMAGE_NAME}:latest
