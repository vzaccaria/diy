
{ writeXcode } = require('./xcode-make/entry')
_ = require('lodash')

{ fillWithData } = require('./make')

_module = ->

    return {
        transcript: (f, options) -> 
            options ?= {}
            options.productName ?= "Product"
            options.authorName ?= "Anonymous"
            console.log JSON.stringify(f.getMeta(options),0,4)
            files = _.map(f.getMeta(options).data.sources, -> 
                               name: it 
                               type: "source.javascript"  
                               path: it 
                               id: uid(16))
            data = {
                productName: options.productName
                authorName: options.authorName
                files: files
            }
            writeXcode(data).then ->
                fillWithData(f.getMeta(options)).then ->
                    it.to('makefile')
    }

module.exports = _module!