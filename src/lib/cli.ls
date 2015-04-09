require! <[ fs path cli colors ./convert glob ]>
cli .= enable \glob

cli.parse do
  skip-runtime:
    \s 'Don\'t include the `runtime.js` on the HTML files'
  json:
    \j 'Save the converted SWF files as JSON only.'
  reporter:
    no 'Changes how information will be printed to stdout.'
    'string' 'pretty'

count = 0
total = 0
files = []

cli.main (args, options) ->
  options.reporter .= to-lower-case!
  for p in args then files ++= glob.sync p
  total := files.length
  console.log '' unless options.reporter is \json
  for til Math.min files.length, 10 then convert-file options

function convert-file options
  file   = files.shift!
  output = file + \. + if options.json then \json else \html

  err, obj <- convert file

  if err
    if options.reporter is \json
      console.log JSON.stringify do
        status: \error
        source: file
        error: err
    else
      console.error "Error converting #file:"
      console.error err + '\n'

    return

  {html, json} = obj.output
  html -= /<script.+runtime\.js.+<\/script>/ if options.skip-runtime

  fs.write-file-sync output, if options.json then json else html

  if options.reporter is \json
    console.log JSON.stringify do
      status: \success
      source: file
      output: output
      messages: obj.messages
  else
    console.log "[#{++count} of #total] ".green +
    path.relative process.cwd!, output

    if obj.messages
      for msg in obj.messages
      then console.log "[ #{msg.type} ] ".yellow + msg.description
      console.log ''

  convert-file options if files.length
