require! {
  fs
  colors
  cli: 'cli'.enable 'glob'
  convert: './convert'
}


cli.parse do
  output-dir:
    'o', 'Directory to save the converted HTML files.'
  skip-runtime:
    's', 'Don\'t include the `runtime.js` on the HTML files'
  json:
    'j', 'Save the converted SWF files as JSON only.'


count = 0
total = 0
files = []
cli.main (args, options) ->
  if options.output-dir
    [path, parent] = /^(.+\/)[^\/]*$/ is args.pop!
    options.output-dir = if fs.statSync path .isDirectory! then path else parent

  files := args.concat!
  total := files.length
  for til 10 then convert-file options


function convert-file options
  file = files.shift!
  [file, parent, name] = /^(.+)\/([^\/]*)$/ is file
  parent = options.output-dir if options.output-dir
  ext = if options.json then 'json' else 'html'
  output = "#parent/#name.#ext"

  error, body <- convert file, options
  return console.log error if error
  error <- fs.writeFile output, body
  return console.log error if error
  console.log "[#{++count} of #total] ".green + output
  convert-file options if files.length
