debug = require('debug')('newmake/packs')
glob = require('glob')
uid = require('uid')

process-stderr-with = (command, processor) ->
    "/bin/bash -c \"(#command) 2> >(#processor 1>&2)\""


_module = ->
          
    iface = { 
        livescript: (dir, deps) ->
            command = (_) -> "lsc -c #{_.source}"
            product = (_) -> "#{_.source.replace(/\..*/, '.js')}"
            @compileFiles(command, product, glob.sync(dir))

        livescriptXc: (dir, deps) ->
            command = (_) -> process-stderr-with "lsc -c #{_.source}", "xcparse"
            product = (_) -> "#{_.source.replace(/\..*/, '.js')}"
            @compileFiles(command, product, glob.sync(dir))

        sixToFive: (dir, deps) ->
            command = (_) -> "6to5 #{_.source} -o #{_.product}"
            product = (_) -> "#{_.source.replace(/\..*/, '.js')}"
            @compileFiles(command, product, glob.sync(dir))

        concat: (body) ->
            command = (_) -> "cat #{_.sources * ' '} > #{_.product}"
            product = (_) -> "concat-#{uid(4)}.js"
            @reduceFiles(command, product, body)

        minify: (body) ->
            command = (_) -> "uglifyjs #{_.source} > #{_.product}"
            product = (_) -> "minified-#{uid(4)}.js"
            @processFiles(command, product, body)

        toFile: (name, body) ->
            command = (_) -> "cp #{_.sources * ' '} #{_.product}"
            product = (_) -> name
            @reduceFiles(command, product, body)

        startWatch: (glob, strip) ->
            glob ?= '.'
            strip ?= ''
            @cmd("#{__dirname}/../../node_modules/.bin/pm2 start #{__dirname}/livereload.js -- #glob -s #strip")

        stopWatch: (strip) ->
            @cmd("#{__dirname}/../../node_modules/.bin/pm2 delete #{__dirname}/livereload.js")

        startServe: (root, port) ->
            root ?= '.'
            port ?= 4000
            @cmd("#{__dirname}/../../node_modules/.bin/pm2 start #{__dirname}/serve.js -- #root -p #port")

        stopServe: (root) ->
            @cmd("#{__dirname}/../../node_modules/.bin/pm2 delete #{__dirname}/serve.js")

    }
  
    return iface
 
module.exports = _module()

