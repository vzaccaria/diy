#!/usr/bin/env lsc 


{ parse, add-plugin } = require('newmake')

parse ->

    @add-plugin "es6", (g) ->
        @compile-files( (-> "6to5 #{it.orig-complete} -o #{it.build-target}" ) , ".js", g)

    @collect "build", ->
        @command-seq -> [
            @toDir "./lib", { strip: "src" }, -> [
                @es6 "src/test/*.js6"
                @livescript "src/*.ls"
                @livescript "src/packs/*.ls"
                @livescript "src/backends/*.ls"
            ]
            @cmd "cp ./lib/index.js ."
        ]

    @collect "all", -> 
        @command-seq -> [
            @make \build
            @cmd "chmod +x ./index.js"
            @cmd "node ./lib/test/treeTest.js > new.mk"
        ]

