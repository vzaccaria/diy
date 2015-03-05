"use strict";

debug = require('debug')('backends/make')
moment = require('moment')
{ cat } = require('shelljs')

Liquid = require("liquid-node")
engine = new Liquid.Engine

_module = ->

    fillWithData = (data) ->
        template = cat("#{__dirname}/../../src/backends/make/template.mk")
        return engine.parseAndRender(template, data)

    iface = {

        fillWithData: fillWithData

        transcript: (f, options) ->
            meta = f.getMeta(options)
            meta.info = { today: moment().format('MMMM D, YYYY') }
            fillWithData(meta).then ->
                console.log it

    }

    return iface

module.exports = _module()
