#!/usr/bin/env lsc

{ parse, add-plugin } = require('newmake')

parse ->

    @add-plugin "es6", (g) ->
        @compile-files( (-> "./node_modules/.bin/babel #{it.orig-complete} -o #{it.build-target}" ) , ".js", g)

    @add-plugin "lsc", (g) ->
        @compile-files( (-> "lsc -b -p -c #{it.orig-complete} > #{it.build-target}" ) , ".js", g)

    @collect "build", -> [
            @toDir "./lib", { strip: "src" }, -> [
                @es6 "src/**/*.js6"
                @lsc "src/**/*.ls"
            ]

            @toDir ".", -> [
                @es6 "tests/common/test0/*.js6"
            ]
    ]

    @collect "all", -> [
        @command-seq -> [
            @make \build
            @cmd "cp ./lib/index.js ."
            @cmd "chmod +x ./lib/packs/serve.js"
            @cmd "chmod +x ./lib/packs/livereload.js"
            @cmd "./tests/test.sh"
            @cmd "cat README.tpl.md | ./node_modules/.bin/stupid-replace '{{description}}' -f description.md > README.md"
        ]
    ]

    @collect "clean", -> [
        @command-seq ->
            @remove-all-targets()
    ]

    for l in ["major", "minor", "patch"]
      @collect "release-#l", -> [
          @cmd "./node_modules/.bin/xyz --increment #l"
      ]
