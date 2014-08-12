require! {
  fs
  request
}

module.exports = (...args) ->
  file = args[0]
  callback = args[2] ? args[1]
  options = args[1] unless typeof! args[1] is 'Function'

  r = do
    error, response, body <~ request.post 'https://www.google.com/doubleclick/studio/swiffy/upload'
    return console.log error if error

    swiffy-data = JSON.parse body.substr(4)
    swiffy-data = swiffy-data[*-3]
    url = swiffy-data[*-1] + swiffyData[*-2]

    error, response, body <~ request url
    return console.log error if error

    body = body.replace /\s+<script src=('|")https?:\/\/www\.gstatic\.com\/swiffy\/[^\/]*\/runtime\.js('|")><\/script>\n/, '' if options.skip-runtime
    body = (/swiffyobject\s*=\s*(.*)(?=\s*<\/script>)/ is body)[1] if options.json

    callback? null, body

  r.form!append 'swfFile', fs.createReadStream(file)
