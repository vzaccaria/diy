.DEFAULT_GOAL := all

.build/0-entry.js: src/backends/xcode-make/entry.js6
	6to5 src/backends/xcode-make/entry.js6 -o .build/0-entry.js

.build/1-parseWithData.js: src/backends/xcode-make/parseWithData.js6
	6to5 src/backends/xcode-make/parseWithData.js6 -o .build/1-parseWithData.js

.build/2-readTemplate.js: src/backends/xcode-make/readTemplate.js6
	6to5 src/backends/xcode-make/readTemplate.js6 -o .build/2-readTemplate.js

.build/3-writeProject.js: src/backends/xcode-make/writeProject.js6
	6to5 src/backends/xcode-make/writeProject.js6 -o .build/3-writeProject.js

.build/4-make4web.js: src/suites/make4web.js6
	6to5 src/suites/make4web.js6 -o .build/4-make4web.js

.build/5-xcode4web.js: src/suites/xcode4web.js6
	6to5 src/suites/xcode4web.js6 -o .build/5-xcode4web.js

.build/6-test0.js: src/test/test0.js6
	6to5 src/test/test0.js6 -o .build/6-test0.js

.build/7-test1.js: src/test/test1.js6
	6to5 src/test/test1.js6 -o .build/7-test1.js

.build/8-make.js: src/backends/make.ls
	lsc -b -p -c src/backends/make.ls > .build/8-make.js

.build/9-xcode-make.js: src/backends/xcode-make.ls
	lsc -b -p -c src/backends/xcode-make.ls > .build/9-xcode-make.js

.build/10-file.js: src/file.ls
	lsc -b -p -c src/file.ls > .build/10-file.js

.build/11-index.js: src/index.ls
	lsc -b -p -c src/index.ls > .build/11-index.js

.build/12-livereload.js: src/packs/livereload.ls
	lsc -b -p -c src/packs/livereload.ls > .build/12-livereload.js

.build/13-serve.js: src/packs/serve.ls
	lsc -b -p -c src/packs/serve.ls > .build/13-serve.js

.build/14-web.js: src/packs/web.ls
	lsc -b -p -c src/packs/web.ls > .build/14-web.js

.build/15-tree.js: src/tree.ls
	lsc -b -p -c src/tree.ls > .build/15-tree.js

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

lib/backends/make.js: .build/8-make.js
	@mkdir -p ./lib//backends
	cp .build/8-make.js $@

lib/backends/xcode-make.js: .build/9-xcode-make.js
	@mkdir -p ./lib//backends
	cp .build/9-xcode-make.js $@

lib/file.js: .build/10-file.js
	@mkdir -p ./lib/
	cp .build/10-file.js $@

lib/index.js: .build/11-index.js
	@mkdir -p ./lib/
	cp .build/11-index.js $@

lib/packs/livereload.js: .build/12-livereload.js
	@mkdir -p ./lib//packs
	cp .build/12-livereload.js $@

lib/packs/serve.js: .build/13-serve.js
	@mkdir -p ./lib//packs
	cp .build/13-serve.js $@

lib/packs/web.js: .build/14-web.js
	@mkdir -p ./lib//packs
	cp .build/14-web.js $@

lib/tree.js: .build/15-tree.js
	@mkdir -p ./lib/
	cp .build/15-tree.js $@

.PHONY : build
build: lib/backends/xcode-make/entry.js lib/backends/xcode-make/parseWithData.js lib/backends/xcode-make/readTemplate.js lib/backends/xcode-make/writeProject.js lib/suites/make4web.js lib/suites/xcode4web.js lib/test/test0.js lib/test/test1.js lib/backends/make.js lib/backends/xcode-make.js lib/file.js lib/index.js lib/packs/livereload.js lib/packs/serve.js lib/packs/web.js lib/tree.js

.PHONY : cmd-16
cmd-16: 
	make build

.PHONY : cmd-17
cmd-17: 
	cp ./lib/index.js .

.PHONY : cmd-18
cmd-18: 
	chmod +x ./lib/packs/serve.js

.PHONY : cmd-19
cmd-19: 
	chmod +x ./lib/packs/livereload.js

.PHONY : cmd-seq-20
cmd-seq-20: 
	make cmd-16
	make cmd-17
	make cmd-18
	make cmd-19

.PHONY : all
all: cmd-seq-20

.PHONY : clean-21
clean-21: 
	rm -rf .build/0-entry.js .build/1-parseWithData.js .build/2-readTemplate.js .build/3-writeProject.js .build/4-make4web.js .build/5-xcode4web.js .build/6-test0.js .build/7-test1.js .build/8-make.js .build/9-xcode-make.js .build/10-file.js .build/11-index.js .build/12-livereload.js .build/13-serve.js .build/14-web.js .build/15-tree.js lib/backends/xcode-make/entry.js lib/backends/xcode-make/parseWithData.js lib/backends/xcode-make/readTemplate.js lib/backends/xcode-make/writeProject.js lib/suites/make4web.js lib/suites/xcode4web.js lib/test/test0.js lib/test/test1.js lib/backends/make.js lib/backends/xcode-make.js lib/file.js lib/index.js lib/packs/livereload.js lib/packs/serve.js lib/packs/web.js lib/tree.js

.PHONY : clean-22
clean-22: 
	rm -rf .build

.PHONY : clean-23
clean-23: 
	mkdir -p .build

.PHONY : cmd-seq-24
cmd-seq-24: 
	make clean-21
	make clean-22
	make clean-23

.PHONY : clean
clean: cmd-seq-24
