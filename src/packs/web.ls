debug = require('debug')('newmake/packs')
glob = require('glob')
uid = require('uid')

_module = ->
          
    iface = { 
        livescript: (dir, deps) ->
            command = (_) -> "lsc -c #{_.source}"
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
    }
  
    return iface
 
module.exports = _module()

