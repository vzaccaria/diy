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

    buildMeta = (f, options) ->


        options ?= {}
        options.default-goal ?= 'all'

        meta = {
            info:
                today: moment().format('YYYY, MM DD')
            options: options
            data: 
                phonyTargets: []
                phonySequentialTargets: []
                targets: []
        }

        for k in f.getPhonyTargetNames!
            if not f.isPhonyTargetSequential(k)
                meta.data.phonyTargets.push {
                    name: k
                    dependencies: f.getTargetDepsAsNames(k)
                }
            else 
                meta.data.phonySequentialTargets.push {
                    name: k
                    dependencies: f.getTargetDepsAsNames(k)
                    actions: f.getPhonyTargetActions(k)
                }

        for k in f.getActualTargetNames!
            meta.data.targets.push {
                name: k
                dependencies: f.getTargetDepsAsNames(k)
                command: f.getTargetCreationCommand(k)
            }
            
        return meta

    iface = { 

        transcript: (f, options) ->
            fillWithData(buildMeta(f,options)).then ->
                console.log it

    }
  
    return iface
 
module.exports = _module()

