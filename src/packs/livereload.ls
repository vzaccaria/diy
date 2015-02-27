
debug     = require('debug')('diy:lib/packs/livereload')
minimatch = require('minimatch')
{docopt}  = require('docopt')
_         = require('lodash')
path      = require('path')

doc = """
Usage:
    livereload GLOB [ -s STRIP ]
    livereload -h | --help 

Options:
    -s, --strip STRIP   strip STRIP prefix from files sent to the livereload server

Arguments
    GLOB                specifies files to be watched (in quotes, e.g. '**/*')

"""

get-option = (a, b, def, o) ->
    if not o[a] and not o[b]
        return def
    else 
        return o[b]


get-options = ->

    o     = docopt(doc)
    strip = get-option('-s' , '--strip' , "" , o)
    files = o['GLOB']

    return { strip, files }

LIVERELOAD_PORT = 35729;

var lr
start-livereload = ->
   lr := require('tiny-lr')()
   debug "Starting livereload at #LIVERELOAD_PORT"
   lr.listen(LIVERELOAD_PORT)

notify-change = (strip, path) ->
  fileName = require('path').relative(strip, path)
  found = false

  delay = setTimeout(_, 100)
  debug("Notifying Livereload for a change to #{fileName}")

  delay ->
    lr.changed body: { files: [fileName] }


watch-dest-files = (notify-targets, cb) ->
        Gaze = require('gaze').Gaze;

        gaze = new Gaze(notify-targets);

        gaze.on 'ready', ->
            debug "Watching destinations"

        gaze.on 'all', cb

main = (argv) ->
    { files, strip } = op = get-options!
    debug op
    debug "Watching for livereload #{files}"
    start-livereload!
    watch-dest-files files, (event, filepath) ->
        notify-change strip, filepath 

main(process.argv)







