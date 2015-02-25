.DEFAULT_GOAL := all

.build/0-test0.js: src/test/test0.js6
	6to5 src/test/test0.js6 -o .build/0-test0.js

.build/1-file.js: src/file.ls
	lsc -b -p -c src/file.ls > .build/1-file.js

.build/2-index.js: src/index.ls
	lsc -b -p -c src/index.ls > .build/2-index.js

.build/3-tree.js: src/tree.ls
	lsc -b -p -c src/tree.ls > .build/3-tree.js

.build/4-web.js: src/packs/web.ls
	lsc -b -p -c src/packs/web.ls > .build/4-web.js

.build/5-make.js: src/backends/make.ls
	lsc -b -p -c src/backends/make.ls > .build/5-make.js

lib/test/test0.js: .build/0-test0.js
	@mkdir -p ./lib//test
	cp .build/0-test0.js $@

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
	make lib/test/test0.js
	make lib/file.js
	make lib/index.js
	make lib/tree.js
	make lib/packs/web.js
	make lib/backends/make.js
	make cmd-6

.PHONY : build
build: cmd-seq-7

.PHONY : clean-8
clean-8: 
	rm -rf .build/0-test0.js .build/1-file.js .build/2-index.js .build/3-tree.js .build/4-web.js .build/5-make.js lib/test/test0.js lib/file.js lib/index.js lib/tree.js lib/packs/web.js lib/backends/make.js

.PHONY : clean-9
clean-9: 
	rm -rf .build

.PHONY : clean-10
clean-10: 
	mkdir -p .build

.PHONY : cmd-11
cmd-11: 
	make build

.PHONY : cmd-seq-12
cmd-seq-12: 
	make clean-8
	make clean-9
	make clean-10
	make cmd-11

.PHONY : all
all: cmd-seq-12
