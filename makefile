.DEFAULT_GOAL := all

.build/0-make4web.js: src/suites/make4web.js6
	./node_modules/.bin/babel src/suites/make4web.js6 -o .build/0-make4web.js

.build/1-test0.js: src/test/test0.js6
	./node_modules/.bin/babel src/test/test0.js6 -o .build/1-test0.js

.build/2-test2.js: src/test/test2.js6
	./node_modules/.bin/babel src/test/test2.js6 -o .build/2-test2.js

.build/3-test3.js: src/test/test3.js6
	./node_modules/.bin/babel src/test/test3.js6 -o .build/3-test3.js

.build/4-test4.js: src/test/test4.js6
	./node_modules/.bin/babel src/test/test4.js6 -o .build/4-test4.js

.build/5-make.js: src/backends/make.ls
	lsc -b -p -c src/backends/make.ls > .build/5-make.js

.build/6-file.js: src/file.ls
	lsc -b -p -c src/file.ls > .build/6-file.js

.build/7-index.js: src/index.ls
	lsc -b -p -c src/index.ls > .build/7-index.js

.build/8-livereload.js: src/packs/livereload.ls
	lsc -b -p -c src/packs/livereload.ls > .build/8-livereload.js

.build/9-serve.js: src/packs/serve.ls
	lsc -b -p -c src/packs/serve.ls > .build/9-serve.js

.build/10-web.js: src/packs/web.ls
	lsc -b -p -c src/packs/web.ls > .build/10-web.js

.build/11-tree.js: src/tree.ls
	lsc -b -p -c src/tree.ls > .build/11-tree.js

lib/suites/make4web.js: .build/0-make4web.js
	@mkdir -p ./lib//suites
	cp .build/0-make4web.js $@

lib/test/test0.js: .build/1-test0.js
	@mkdir -p ./lib//test
	cp .build/1-test0.js $@

lib/test/test2.js: .build/2-test2.js
	@mkdir -p ./lib//test
	cp .build/2-test2.js $@

lib/test/test3.js: .build/3-test3.js
	@mkdir -p ./lib//test
	cp .build/3-test3.js $@

lib/test/test4.js: .build/4-test4.js
	@mkdir -p ./lib//test
	cp .build/4-test4.js $@

lib/backends/make.js: .build/5-make.js
	@mkdir -p ./lib//backends
	cp .build/5-make.js $@

lib/file.js: .build/6-file.js
	@mkdir -p ./lib/
	cp .build/6-file.js $@

lib/index.js: .build/7-index.js
	@mkdir -p ./lib/
	cp .build/7-index.js $@

lib/packs/livereload.js: .build/8-livereload.js
	@mkdir -p ./lib//packs
	cp .build/8-livereload.js $@

lib/packs/serve.js: .build/9-serve.js
	@mkdir -p ./lib//packs
	cp .build/9-serve.js $@

lib/packs/web.js: .build/10-web.js
	@mkdir -p ./lib//packs
	cp .build/10-web.js $@

lib/tree.js: .build/11-tree.js
	@mkdir -p ./lib/
	cp .build/11-tree.js $@

.PHONY : build
build: lib/suites/make4web.js lib/test/test0.js lib/test/test2.js lib/test/test3.js lib/test/test4.js lib/backends/make.js lib/file.js lib/index.js lib/packs/livereload.js lib/packs/serve.js lib/packs/web.js lib/tree.js

.PHONY : cmd-12
cmd-12: 
	make build

.PHONY : cmd-13
cmd-13: 
	cp ./lib/index.js .

.PHONY : cmd-14
cmd-14: 
	chmod +x ./lib/packs/serve.js

.PHONY : cmd-15
cmd-15: 
	chmod +x ./lib/packs/livereload.js

.PHONY : cmd-16
cmd-16: 
	./tests/test.sh

.PHONY : cmd-seq-17
cmd-seq-17: 
	make cmd-12
	make cmd-13
	make cmd-14
	make cmd-15
	make cmd-16

.PHONY : all
all: cmd-seq-17

.PHONY : clean-18
clean-18: 
	rm -rf .build/0-make4web.js .build/1-test0.js .build/2-test2.js .build/3-test3.js .build/4-test4.js .build/5-make.js .build/6-file.js .build/7-index.js .build/8-livereload.js .build/9-serve.js .build/10-web.js .build/11-tree.js lib/suites/make4web.js lib/test/test0.js lib/test/test2.js lib/test/test3.js lib/test/test4.js lib/backends/make.js lib/file.js lib/index.js lib/packs/livereload.js lib/packs/serve.js lib/packs/web.js lib/tree.js

.PHONY : clean-19
clean-19: 
	rm -rf .build

.PHONY : clean-20
clean-20: 
	mkdir -p .build

.PHONY : cmd-seq-21
cmd-seq-21: 
	make clean-18
	make clean-19
	make clean-20

.PHONY : clean
clean: cmd-seq-21

.PHONY : cmd-22
cmd-22: 
	./node_modules/.bin/xyz --increment major

.PHONY : release-major
release-major: cmd-22

.PHONY : cmd-23
cmd-23: 
	./node_modules/.bin/xyz --increment minor

.PHONY : release-minor
release-minor: cmd-23

.PHONY : cmd-24
cmd-24: 
	./node_modules/.bin/xyz --increment patch

.PHONY : release-patch
release-patch: cmd-24
