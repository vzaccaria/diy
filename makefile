.DEFAULT_GOAL := all

.build/0-test0.js: src/test/test0.js6
	6to5 src/test/test0.js6 -o .build/0-test0.js

.build/1-treeTest.js: src/test/treeTest.js6
	6to5 src/test/treeTest.js6 -o .build/1-treeTest.js

.build/2-file.js: src/file.ls
	lsc -b -p -c src/file.ls > .build/2-file.js

.build/3-index.js: src/index.ls
	lsc -b -p -c src/index.ls > .build/3-index.js

.build/4-tree.js: src/tree.ls
	lsc -b -p -c src/tree.ls > .build/4-tree.js

.build/5-web.js: src/packs/web.ls
	lsc -b -p -c src/packs/web.ls > .build/5-web.js

.build/6-make.js: src/backends/make.ls
	lsc -b -p -c src/backends/make.ls > .build/6-make.js

lib/test/test0.js: .build/0-test0.js
	@mkdir -p ./lib//test
	cp .build/0-test0.js $@

lib/test/treeTest.js: .build/1-treeTest.js
	@mkdir -p ./lib//test
	cp .build/1-treeTest.js $@

lib/file.js: .build/2-file.js
	@mkdir -p ./lib/
	cp .build/2-file.js $@

lib/index.js: .build/3-index.js
	@mkdir -p ./lib/
	cp .build/3-index.js $@

lib/tree.js: .build/4-tree.js
	@mkdir -p ./lib/
	cp .build/4-tree.js $@

lib/packs/web.js: .build/5-web.js
	@mkdir -p ./lib//packs
	cp .build/5-web.js $@

lib/backends/make.js: .build/6-make.js
	@mkdir -p ./lib//backends
	cp .build/6-make.js $@

.PHONY : cmd-7
cmd-7: 
	cp ./lib/index.js .

.PHONY : cmd-seq-8
cmd-seq-8: 
	make lib/test/test0.js
	make lib/test/treeTest.js
	make lib/file.js
	make lib/index.js
	make lib/tree.js
	make lib/packs/web.js
	make lib/backends/make.js
	make cmd-7

.PHONY : build
build: cmd-seq-8

.PHONY : clean-9
clean-9: 
	rm -rf .build/0-test0.js .build/1-treeTest.js .build/2-file.js .build/3-index.js .build/4-tree.js .build/5-web.js .build/6-make.js lib/test/test0.js lib/test/treeTest.js lib/file.js lib/index.js lib/tree.js lib/packs/web.js lib/backends/make.js

.PHONY : clean-10
clean-10: 
	rm -rf .build

.PHONY : clean-11
clean-11: 
	mkdir -p .build

.PHONY : cmd-12
cmd-12: 
	make build

.PHONY : cmd-seq-13
cmd-seq-13: 
	make clean-9
	make clean-10
	make clean-11
	make cmd-12

.PHONY : all
all: cmd-seq-13
