#!/usr/bin/env lsc 


{ parse, add-plugin } = require('newmake')

parse ->

    @add-plugin "es6", (g) ->
        @compile-files( (-> "6to5 #{it.orig-complete} -o #{it.build-target}" ) , ".js", g)

    @add-plugin "lsc", (g) ->
        @compile-files( (-> "lsc -b -p -c #{it.orig-complete} > #{it.build-target}" ) , ".js", g)

    @collect "build", ->
            @toDir "./lib", { strip: "src" }, -> [
                @es6 "src/**/*.js6"
                @lsc "src/**/*.ls"
            ]

    @collect "all", -> 
        @command-seq -> [
            @make \build
            @cmd "cp ./lib/index.js ."
            @cmd "chmod +x ./lib/packs/serve.js"
            @cmd "chmod +x ./lib/packs/livereload.js"
        ]

    @collect "clean", -> [
        @command-seq -> 
            @remove-all-targets()
    ]
