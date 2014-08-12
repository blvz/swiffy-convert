# swiffy-convert

Converts SWF animations to HTML, using the Google's Swiffy online converter.

# Requirements

[Node.js](http://nodejs.org)

# CLI

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

Specify an output directory:

```bash
$ swiffy-convert projects/flash-anims/**/*.swf -o ~/Desktop
$ swiffy-convert projects/flash-anims/**/*.swf --output ~/Desktop
```

Mix flags. For example, save JSON files to Desktop:

```bash
$ swiffy-convert projects/flash-anims/**/*.swf -jo ~/Desktop
```


# Node.js

Install on your project

```bash
$ npm install swiffy-convert
```

Then use it as a module:

```javascript
var swiffyConvert = require('swiffy-convert');
swiffyConvert('path/to/file.swf', {
  json: false,
  skipRuntime: false,
  outputDir: ''
  }, function(error, body) {

    if (error) {
      return console.log(error);
    }
    console.log('Swiffy HTML:\n' + body);
  }
);
```

# License

MIT
