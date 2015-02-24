.DEFAULT_GOAL := all

.build/0-treeTest.js: src/test/treeTest.js6
	6to5 src/test/treeTest.js6 -o .build/0-treeTest.js

.build/1-file.js: src/file.ls
	lsc -p -c src/file.ls > .build/1-file.js

.build/2-index.js: src/index.ls
	lsc -p -c src/index.ls > .build/2-index.js

.build/3-tree.js: src/tree.ls
	lsc -p -c src/tree.ls > .build/3-tree.js

.build/4-web.js: src/packs/web.ls
	lsc -p -c src/packs/web.ls > .build/4-web.js

.build/5-make.js: src/backends/make.ls
	lsc -p -c src/backends/make.ls > .build/5-make.js

lib/test/treeTest.js: .build/0-treeTest.js
	@mkdir -p ./lib//test
	cp .build/0-treeTest.js $@

lib/file.js: .build/1-file.js
	@mkdir -p ./lib/
	cp .build/1-file.js $@

lib/index.js: .build/2-index.js
	@mkdir -p ./lib/
	cp .build/2-index.js $@

lib/tree.js: .build/3-tree.js
	@mkdir -p ./lib/
	cp .build/3-tree.js $@

lib/packs/web.js: .build/4-web.js
	@mkdir -p ./lib//packs
	cp .build/4-web.js $@

lib/backends/make.js: .build/5-make.js
	@mkdir -p ./lib//backends
	cp .build/5-make.js $@

.PHONY : cmd-6
cmd-6: 
	cp ./lib/index.js .

.PHONY : cmd-seq-7
cmd-seq-7: 
	make lib/test/treeTest.js
	make lib/file.js
	make lib/index.js
	make lib/tree.js
	make lib/packs/web.js
	make lib/backends/make.js
	make cmd-6

.PHONY : build
build: cmd-seq-7

.PHONY : cmd-8
cmd-8: 
	make build

.PHONY : cmd-9
cmd-9: 
	chmod +x ./index.js

.PHONY : cmd-10
cmd-10: 
	node ./lib/test/treeTest.js > new.mk

.PHONY : cmd-seq-11
cmd-seq-11: 
	make cmd-8
	make cmd-9
	make cmd-10

.PHONY : all
all: cmd-seq-11
