# swiffy-convert

Converts SWF animations to HTML, using the Google's Swiffy online converter.

## Requirements

[Node.js](http://nodejs.org)

## CLI

Install globally with npm

```bash
$ npm install -g swiffy-convert
```

Then convert SWF files to HTML:

```bash
$ swiffy-convert projects/flash-anims/**/*.swf
```

JSON objects only:

```bash
$ swiffy-convert projects/flash-anims/**/*.swf -j
$ swiffy-convert projects/flash-anims/**/*.swf --json
```

Don't include the `runtime.js`:

```bash
$ swiffy-convert projects/flash-anims/**/*.swf -s
$ swiffy-convert projects/flash-anims/**/*.swf --skip-runtime
```

You can also get the convertion results printed as JSON, one by line:

```bash
$ swiffy-convert projects/flash-anims/**/*.swf --reporter json
```


## Node.js

Install on your project

```bash
$ npm install swiffy-convert
```

Then use it as a module:

```javascript
var fs = require('fs');
var convert = require('swiffy-convert');

var path = 'path/to/file.swf',
    buf  = fs.readFileSync(path),
    strm = fs.createReadStream(path);

// convert a file in a path
convert('path/to/file.swf', function(err, result) {
    if (err) return console.error(err);

    fs.writeFileSync('path/to/file.swf.html', result.output.html);
    fs.writeFileSync('path/to/file.swf.json', result.output.json);
    console.log(result);
  }
);

// convert a file, by its buffer
convert(buf, function(err, result) {
  if (err) return console.error(err);
  console.log(result);
});

// convert a file stream
convert(strm, function(err, result) {
  if (err) return console.error(err);
  console.log(result);
});
```


## DIY

This project was done in [LiveScript](https://github.com/gkz/LiveScript).
`make install` installs it locally, along with any other dependency.
`make build` compiles the `src` to JavaScript.
`make test` builds everything and run the tests.


## License

MIT
