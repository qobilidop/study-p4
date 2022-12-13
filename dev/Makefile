.PHONY: update
update:
	git submodule update --init --recursive

.PHONY: pull-all
pull-all:
	find . -maxdepth 1 -mindepth 1 -type d -execdir bash -c 'cd "{}" && [ -a .git ] && pwd && git pull' \;

.PHONY: build-all
build-all:
	./build-pi.sh
	./build-bmv2.sh
	./build-pi-bmv2.sh
	./build-p4c.sh
