require! <[ fs cli colors ./convert ]>
cli .= enable \glob

cli.parse do
  skip-runtime:
    \s 'Don\'t include the `runtime.js` on the HTML files'
  json:
    \j 'Save the converted SWF files as JSON only.'

const NUM_TRIES = 3

count = 0
total = 0
files = []

cli.main (args, options) ->
  files := args.concat!map -> tries: 0 path: it
  total := files.length
  console.log ''
  for til Math.min files.length, 10 then convert-file options

function convert-file options
  file = files.shift!
  [path, parent, name] = /^(.+)\/([^\/]*)$/ is file.path
  ext    = if options.json then \json else \html
  output = "#parent/#name.#ext"

  file.tries++

  err, obj <- convert path

  if err
    console.error "Error converting #{file.path}
                 \ on try #{file.tries}/#{NUM_TRIES}:"
    console.error err + '\n'
    files.push file if file.tries < NUM_TRIES
    return

  {html, json} = obj.output
  html -= /<script.+runtime\.js.+<\/script>/ if options.skip-runtime

  fs.write-file-sync output, if options.json then json else html

  console.log "[#{++count} of #total] ".green + output
  if obj.messages
    for msg in obj.messages
    then console.log "[ #{msg.type} ] ".yellow + msg.description
    console.log ''

  convert-file options if files.length
