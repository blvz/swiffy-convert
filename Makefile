default: all

LSC = node_modules/LiveScript/bin/lsc

all: build

build: package.json

package.json: package.json.ls
	$(LSC) --compile package.json.ls
