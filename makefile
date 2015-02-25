.DEFAULT_GOAL := all

.build/0-entry.js: src/backends/xcode-make/entry.js6
	6to5 src/backends/xcode-make/entry.js6 -o .build/0-entry.js

.build/1-parseWithData.js: src/backends/xcode-make/parseWithData.js6
	6to5 src/backends/xcode-make/parseWithData.js6 -o .build/1-parseWithData.js

.build/2-readTemplate.js: src/backends/xcode-make/readTemplate.js6
	6to5 src/backends/xcode-make/readTemplate.js6 -o .build/2-readTemplate.js

.build/3-writeProject.js: src/backends/xcode-make/writeProject.js6
	6to5 src/backends/xcode-make/writeProject.js6 -o .build/3-writeProject.js

.build/4-test0.js: src/test/test0.js6
	6to5 src/test/test0.js6 -o .build/4-test0.js

.build/5-make.js: src/backends/make.ls
	lsc -b -p -c src/backends/make.ls > .build/5-make.js

.build/6-file.js: src/file.ls
	lsc -b -p -c src/file.ls > .build/6-file.js

.build/7-index.js: src/index.ls
	lsc -b -p -c src/index.ls > .build/7-index.js

.build/8-web.js: src/packs/web.ls
	lsc -b -p -c src/packs/web.ls > .build/8-web.js

.build/9-tree.js: src/tree.ls
	lsc -b -p -c src/tree.ls > .build/9-tree.js

lib/backends/xcode-make/entry.js: .build/0-entry.js
	@mkdir -p ./lib//backends/xcode-make
	cp .build/0-entry.js $@

lib/backends/xcode-make/parseWithData.js: .build/1-parseWithData.js
	@mkdir -p ./lib//backends/xcode-make
	cp .build/1-parseWithData.js $@

lib/backends/xcode-make/readTemplate.js: .build/2-readTemplate.js
	@mkdir -p ./lib//backends/xcode-make
	cp .build/2-readTemplate.js $@

lib/backends/xcode-make/writeProject.js: .build/3-writeProject.js
	@mkdir -p ./lib//backends/xcode-make
	cp .build/3-writeProject.js $@

lib/test/test0.js: .build/4-test0.js
	@mkdir -p ./lib//test
	cp .build/4-test0.js $@

lib/backends/make.js: .build/5-make.js
	@mkdir -p ./lib//backends
	cp .build/5-make.js $@

lib/file.js: .build/6-file.js
	@mkdir -p ./lib/
	cp .build/6-file.js $@

lib/index.js: .build/7-index.js
	@mkdir -p ./lib/
	cp .build/7-index.js $@

lib/packs/web.js: .build/8-web.js
	@mkdir -p ./lib//packs
	cp .build/8-web.js $@

lib/tree.js: .build/9-tree.js
	@mkdir -p ./lib/
	cp .build/9-tree.js $@

.PHONY : cmd-10
cmd-10: 
	cp ./lib/index.js .

.PHONY : cmd-seq-11
cmd-seq-11: 
	make lib/backends/xcode-make/entry.js
	make lib/backends/xcode-make/parseWithData.js
	make lib/backends/xcode-make/readTemplate.js
	make lib/backends/xcode-make/writeProject.js
	make lib/test/test0.js
	make lib/backends/make.js
	make lib/file.js
	make lib/index.js
	make lib/packs/web.js
	make lib/tree.js
	make cmd-10

.PHONY : build
build: cmd-seq-11

.PHONY : cmd-12
cmd-12: 
	make build

.PHONY : cmd-seq-13
cmd-seq-13: 
	make cmd-12

.PHONY : all
all: cmd-seq-13

.PHONY : clean-14
clean-14: 
	rm -rf .build/0-entry.js .build/1-parseWithData.js .build/2-readTemplate.js .build/3-writeProject.js .build/4-test0.js .build/5-make.js .build/6-file.js .build/7-index.js .build/8-web.js .build/9-tree.js lib/backends/xcode-make/entry.js lib/backends/xcode-make/parseWithData.js lib/backends/xcode-make/readTemplate.js lib/backends/xcode-make/writeProject.js lib/test/test0.js lib/backends/make.js lib/file.js lib/index.js lib/packs/web.js lib/tree.js

.PHONY : clean-15
clean-15: 
	rm -rf .build

.PHONY : clean-16
clean-16: 
	mkdir -p .build

.PHONY : cmd-seq-17
cmd-seq-17: 
	make clean-14
	make clean-15
	make clean-16

.PHONY : clean
clean: cmd-seq-17
