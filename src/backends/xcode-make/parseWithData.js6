var debug = require('debug')('parseWithData')

var _module = () => {

    var Liquid = require("liquid-node")
    var engine = new Liquid.Engine

    var fillWithData = (template, data) => {
        return engine.parseAndRender(template, data).then(
            (proj) => {
                return {
                    projectFile: proj,
                    metadata: data
                }
            }
        )
    }

    return {
        fillWithData: fillWithData
    }
}

module.exports = _module()