
debug     = require('debug')('diy:lib/packs/serve')
minimatch = require('minimatch')
{docopt}  = require('docopt')
_         = require('lodash')
path      = require('path')

doc = """
Usage:
    serve ROOT [ -p PORT ]
    serve -h | --help

Options:
    -p, --port PORT       PORT

Arguments:
    ROOT                  Root to serve the files from; files are served with livereload code baked in

"""

get-option = (a, b, def, o) ->
    if not o[a] and not o[b]
        return def
    else
        return o[b]


get-options = ->
    o     = docopt(doc)
    port = get-option('-p', '--port', '4000', o)
    root = o['ROOT']
    return { root, port }

startExpress = (EXPRESS_ROOT, EXPRESS_PORT) ->
  express = require('express');
  app = express();
  app.use(require('connect-livereload')())
  app.use(express.static(EXPRESS_ROOT, {maxAge: 0}));
  app.listen(EXPRESS_PORT);
  debug "Serving #{EXPRESS_ROOT} at port #{EXPRESS_PORT}"
  debug "Added connect-livereload: "


main = ->
    { root, port } = op = get-options!
    debug op
    startExpress root, port

main!
