testcase = httptime
working_dir = $(dir $(realpath $(firstword $(MAKEFILE_LIST))))

help:
	@echo "Available commands:"
	@echo "  docker:          Build the docker container"

build: Dockerfile
	docker build -t urlstuff .

test:
	docker run -it --rm urlstuff /bin/sh

run:
	docker run \
	--privileged \
	-it \
	-v $(working_dir)/results/$(testcase):/opt/proxygen/results \
	-w /opt/proxygen/cases/$(testcase) \
	urlstuff /opt/proxygen/cases/$(testcase)/run_afl.sh
