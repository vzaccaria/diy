.DEFAULT_GOAL := all

.build/0-make4web.js: src/suites/make4web.js6
	./node_modules/.bin/babel src/suites/make4web.js6 -o .build/0-make4web.js

.build/1-make.js: src/backends/make.ls
	lsc -b -p -c src/backends/make.ls > .build/1-make.js

.build/2-file.js: src/file.ls
	lsc -b -p -c src/file.ls > .build/2-file.js

.build/3-index.js: src/index.ls
	lsc -b -p -c src/index.ls > .build/3-index.js

.build/4-livereload.js: src/packs/livereload.ls
	lsc -b -p -c src/packs/livereload.ls > .build/4-livereload.js

.build/5-serve.js: src/packs/serve.ls
	lsc -b -p -c src/packs/serve.ls > .build/5-serve.js

.build/6-web.js: src/packs/web.ls
	lsc -b -p -c src/packs/web.ls > .build/6-web.js

.build/7-tree.js: src/tree.ls
	lsc -b -p -c src/tree.ls > .build/7-tree.js

lib/suites/make4web.js: .build/0-make4web.js
	@mkdir -p ./lib//suites
	cp .build/0-make4web.js $@

lib/backends/make.js: .build/1-make.js
	@mkdir -p ./lib//backends
	cp .build/1-make.js $@

lib/file.js: .build/2-file.js
	@mkdir -p ./lib/
	cp .build/2-file.js $@

lib/index.js: .build/3-index.js
	@mkdir -p ./lib/
	cp .build/3-index.js $@

lib/packs/livereload.js: .build/4-livereload.js
	@mkdir -p ./lib//packs
	cp .build/4-livereload.js $@

lib/packs/serve.js: .build/5-serve.js
	@mkdir -p ./lib//packs
	cp .build/5-serve.js $@

lib/packs/web.js: .build/6-web.js
	@mkdir -p ./lib//packs
	cp .build/6-web.js $@

lib/tree.js: .build/7-tree.js
	@mkdir -p ./lib/
	cp .build/7-tree.js $@

.build/8-test0.js: tests/common/test0/test0.js6
	./node_modules/.bin/babel tests/common/test0/test0.js6 -o .build/8-test0.js

tests/common/test0/test0.js: .build/8-test0.js
	@mkdir -p ./tests/common/test0
	cp .build/8-test0.js $@

.PHONY : build
build: lib/suites/make4web.js lib/backends/make.js lib/file.js lib/index.js lib/packs/livereload.js lib/packs/serve.js lib/packs/web.js lib/tree.js tests/common/test0/test0.js

.PHONY : cmd-9
cmd-9: 
	make build

.PHONY : cmd-10
cmd-10: 
	cp ./lib/index.js .

.PHONY : cmd-11
cmd-11: 
	chmod +x ./lib/packs/serve.js

.PHONY : cmd-12
cmd-12: 
	chmod +x ./lib/packs/livereload.js

.PHONY : cmd-13
cmd-13: 
	./tests/test.sh

.PHONY : cmd-seq-14
cmd-seq-14: 
	make cmd-9
	make cmd-10
	make cmd-11
	make cmd-12
	make cmd-13

.PHONY : all
all: cmd-seq-14

.PHONY : clean-15
clean-15: 
	rm -rf .build/0-make4web.js .build/1-make.js .build/2-file.js .build/3-index.js .build/4-livereload.js .build/5-serve.js .build/6-web.js .build/7-tree.js lib/suites/make4web.js lib/backends/make.js lib/file.js lib/index.js lib/packs/livereload.js lib/packs/serve.js lib/packs/web.js lib/tree.js .build/8-test0.js tests/common/test0/test0.js

.PHONY : clean-16
clean-16: 
	rm -rf .build

.PHONY : clean-17
clean-17: 
	mkdir -p .build

.PHONY : cmd-seq-18
cmd-seq-18: 
	make clean-15
	make clean-16
	make clean-17

.PHONY : clean
clean: cmd-seq-18

.PHONY : cmd-19
cmd-19: 
	./node_modules/.bin/xyz --increment major

.PHONY : release-major
release-major: cmd-19

.PHONY : cmd-20
cmd-20: 
	./node_modules/.bin/xyz --increment minor

.PHONY : release-minor
release-minor: cmd-20

.PHONY : cmd-21
cmd-21: 
	./node_modules/.bin/xyz --increment patch

.PHONY : release-patch
release-patch: cmd-21
