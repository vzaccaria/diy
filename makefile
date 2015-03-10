.DEFAULT_GOAL := all

.build/0-entry.js: src/backends/xcode-make/entry.js6
	./node_modules/.bin/babel src/backends/xcode-make/entry.js6 -o .build/0-entry.js

.build/1-parseWithData.js: src/backends/xcode-make/parseWithData.js6
	./node_modules/.bin/babel src/backends/xcode-make/parseWithData.js6 -o .build/1-parseWithData.js

.build/2-readTemplate.js: src/backends/xcode-make/readTemplate.js6
	./node_modules/.bin/babel src/backends/xcode-make/readTemplate.js6 -o .build/2-readTemplate.js

.build/3-writeProject.js: src/backends/xcode-make/writeProject.js6
	./node_modules/.bin/babel src/backends/xcode-make/writeProject.js6 -o .build/3-writeProject.js

.build/4-make4web.js: src/suites/make4web.js6
	./node_modules/.bin/babel src/suites/make4web.js6 -o .build/4-make4web.js

.build/5-xcode4web.js: src/suites/xcode4web.js6
	./node_modules/.bin/babel src/suites/xcode4web.js6 -o .build/5-xcode4web.js

.build/6-test0.js: src/test/test0.js6
	./node_modules/.bin/babel src/test/test0.js6 -o .build/6-test0.js

.build/7-test1.js: src/test/test1.js6
	./node_modules/.bin/babel src/test/test1.js6 -o .build/7-test1.js

.build/8-test2.js: src/test/test2.js6
	./node_modules/.bin/babel src/test/test2.js6 -o .build/8-test2.js

.build/9-test3.js: src/test/test3.js6
	./node_modules/.bin/babel src/test/test3.js6 -o .build/9-test3.js

.build/10-test4.js: src/test/test4.js6
	./node_modules/.bin/babel src/test/test4.js6 -o .build/10-test4.js

.build/11-make.js: src/backends/make.ls
	lsc -b -p -c src/backends/make.ls > .build/11-make.js

.build/12-xcode-make.js: src/backends/xcode-make.ls
	lsc -b -p -c src/backends/xcode-make.ls > .build/12-xcode-make.js

.build/13-file.js: src/file.ls
	lsc -b -p -c src/file.ls > .build/13-file.js

.build/14-index.js: src/index.ls
	lsc -b -p -c src/index.ls > .build/14-index.js

.build/15-livereload.js: src/packs/livereload.ls
	lsc -b -p -c src/packs/livereload.ls > .build/15-livereload.js

.build/16-serve.js: src/packs/serve.ls
	lsc -b -p -c src/packs/serve.ls > .build/16-serve.js

.build/17-web.js: src/packs/web.ls
	lsc -b -p -c src/packs/web.ls > .build/17-web.js

.build/18-tree.js: src/tree.ls
	lsc -b -p -c src/tree.ls > .build/18-tree.js

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

lib/suites/make4web.js: .build/4-make4web.js
	@mkdir -p ./lib//suites
	cp .build/4-make4web.js $@

lib/suites/xcode4web.js: .build/5-xcode4web.js
	@mkdir -p ./lib//suites
	cp .build/5-xcode4web.js $@

lib/test/test0.js: .build/6-test0.js
	@mkdir -p ./lib//test
	cp .build/6-test0.js $@

lib/test/test1.js: .build/7-test1.js
	@mkdir -p ./lib//test
	cp .build/7-test1.js $@

lib/test/test2.js: .build/8-test2.js
	@mkdir -p ./lib//test
	cp .build/8-test2.js $@

lib/test/test3.js: .build/9-test3.js
	@mkdir -p ./lib//test
	cp .build/9-test3.js $@

lib/test/test4.js: .build/10-test4.js
	@mkdir -p ./lib//test
	cp .build/10-test4.js $@

lib/backends/make.js: .build/11-make.js
	@mkdir -p ./lib//backends
	cp .build/11-make.js $@

lib/backends/xcode-make.js: .build/12-xcode-make.js
	@mkdir -p ./lib//backends
	cp .build/12-xcode-make.js $@

lib/file.js: .build/13-file.js
	@mkdir -p ./lib/
	cp .build/13-file.js $@

lib/index.js: .build/14-index.js
	@mkdir -p ./lib/
	cp .build/14-index.js $@

lib/packs/livereload.js: .build/15-livereload.js
	@mkdir -p ./lib//packs
	cp .build/15-livereload.js $@

lib/packs/serve.js: .build/16-serve.js
	@mkdir -p ./lib//packs
	cp .build/16-serve.js $@

lib/packs/web.js: .build/17-web.js
	@mkdir -p ./lib//packs
	cp .build/17-web.js $@

lib/tree.js: .build/18-tree.js
	@mkdir -p ./lib/
	cp .build/18-tree.js $@

.PHONY : build
build: lib/backends/xcode-make/entry.js lib/backends/xcode-make/parseWithData.js lib/backends/xcode-make/readTemplate.js lib/backends/xcode-make/writeProject.js lib/suites/make4web.js lib/suites/xcode4web.js lib/test/test0.js lib/test/test1.js lib/test/test2.js lib/test/test3.js lib/test/test4.js lib/backends/make.js lib/backends/xcode-make.js lib/file.js lib/index.js lib/packs/livereload.js lib/packs/serve.js lib/packs/web.js lib/tree.js

.PHONY : cmd-19
cmd-19: 
	./node_modules/.bin/verb

.PHONY : cmd-20
cmd-20: 
	make build

.PHONY : cmd-21
cmd-21: 
	cp ./lib/index.js .

.PHONY : cmd-22
cmd-22: 
	chmod +x ./lib/packs/serve.js

.PHONY : cmd-23
cmd-23: 
	chmod +x ./lib/packs/livereload.js

.PHONY : cmd-24
cmd-24: 
	./tests/test.sh

.PHONY : cmd-seq-25
cmd-seq-25: 
	make cmd-20
	make cmd-21
	make cmd-22
	make cmd-23
	make cmd-24

.PHONY : all
all: cmd-19 cmd-seq-25

.PHONY : clean-26
clean-26: 
	rm -rf .build/0-entry.js .build/1-parseWithData.js .build/2-readTemplate.js .build/3-writeProject.js .build/4-make4web.js .build/5-xcode4web.js .build/6-test0.js .build/7-test1.js .build/8-test2.js .build/9-test3.js .build/10-test4.js .build/11-make.js .build/12-xcode-make.js .build/13-file.js .build/14-index.js .build/15-livereload.js .build/16-serve.js .build/17-web.js .build/18-tree.js lib/backends/xcode-make/entry.js lib/backends/xcode-make/parseWithData.js lib/backends/xcode-make/readTemplate.js lib/backends/xcode-make/writeProject.js lib/suites/make4web.js lib/suites/xcode4web.js lib/test/test0.js lib/test/test1.js lib/test/test2.js lib/test/test3.js lib/test/test4.js lib/backends/make.js lib/backends/xcode-make.js lib/file.js lib/index.js lib/packs/livereload.js lib/packs/serve.js lib/packs/web.js lib/tree.js

.PHONY : clean-27
clean-27: 
	rm -rf .build

.PHONY : clean-28
clean-28: 
	mkdir -p .build

.PHONY : cmd-seq-29
cmd-seq-29: 
	make clean-26
	make clean-27
	make clean-28

.PHONY : clean
clean: cmd-seq-29
