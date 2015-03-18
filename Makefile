default: all

LSC=./node_modules/LiveScript/bin/lsc

all: build

metadata: package.json.ls
	@ [ -f "$(LSC)" ] || npm install LiveScript
	@ $(LSC) -c *.json.ls

build: metadata
	@ $(LSC) -c src/lib/*.ls
	@ mv src/lib/*.js lib

test: build
	@ $(LSC) test/*.ls

install: metadata
	@ npm install
