.PHONY: update
update:
	git submodule update --init --recursive

.PHONY: build-all
build-all:
	./build-pi.sh
	./build-bmv2.sh
	./build-pi-bmv2.sh
	./build-p4c.sh
