.PHONY: test run clean dep rpm

all: test

test:
	./scripts/test.sh

clean:
	rm -rf .tnt*

run:
	FG=1 CONF=./conf.lua tarantoolctl start init.lua

dep:
	tarantool dep.lua --meta-file ./meta.yaml --tree ./.rocks

deppy:
	python dep.py --meta-file=./meta.yaml --tree=./.rocks

rpm:
	rpmbuild -ba --define="SRC_DIR ${PWD}" rpm/{{__appname__}}.spec
