_      = require('lodash')
debug  = require('debug')('diy:file')
assert = require('assert')
path   = require('path')
moment = require('moment')

class target 
    (@name, @depNames) ~>
        debug "Creating new target: #{@name} - deps: #{depNames}"
        debug @depNames
        assert(@name)
        assert(_.is-array(@depNames))
        _.map @depNames, ->
            assert(_.is-string(it))
        @name = path.normalize(@name)
        _.map @depNames, ->
            path.normalize(it)

class phony extends target 
    (@name, @depNames, @options) ~>
        assert(_.is-object(@options))
        super(@name, @depNames)

class product extends target
    (@name, @productOf, @command, @deps) ~> 
        debug("Created product #{@name}")
        assert(@productOf)
        assert(@command)
        super(@name, @deps)



class targetStore 
    ~>
        @_targets = {}

    ensureTargetIsPhony: (tName) ~>
        assert(@_targets[tName].constructor.name == 'phony')

    addTarget: (target) ~>
        @_targets[target.name] = target

    addSources: (sources) ~>
        @_sources = sources

    getPhonyTargetNames: ~>
        _.keys(_.omit @_targets, (.constructor.name != 'phony')) # on values

    getActualTargetNames: ~>
        _.keys(_.omit @_targets, (.constructor.name == 'phony')) # on values

    getTargetDepsAsNames: (tName) ~>
        _.uniq(@_targets[tName].depNames)

    getPhonyTargetActions: (tName) ~>
        @ensureTargetIsPhony(tName)
        if @_targets[tName].options?.actions? 
            return @_targets[tName].options.actions
        else    
            return []

    isPhonyTargetSequential: (tName) ~>
        @ensureTargetIsPhony(tName)
        @_targets[tName].options?.sequential? and @_targets[tName].options.sequential

    getTargetCreationCommand: (tName) ~>
        if @_targets[tName].constructor.name == 'phony'
            throw "Sorry, #tname is not a construction target"
        else 
            @_targets[tName].command

    getMeta: (options) ~>
        options ?= {}
        options.default-goal ?= 'all'

        meta = {
            options: options
            data: 
                phonyTargets: []
                phonySequentialTargets: []
                targets: []
                sources: @_sources
        }

        for k in @getPhonyTargetNames!
            if not @isPhonyTargetSequential(k)
                meta.data.phonyTargets.push {
                    name: k
                    dependencies: @getTargetDepsAsNames(k)
                }
            else 
                meta.data.phonySequentialTargets.push {
                    name: k
                    dependencies: @getTargetDepsAsNames(k)
                    actions: @getPhonyTargetActions(k)
                }

        for k in @getActualTargetNames!
            meta.data.targets.push {
                name: k
                dependencies: @getTargetDepsAsNames(k)
                command: @getTargetCreationCommand(k)
            }
            
        return meta



module.exports = { product, phony, targetStore }