# swiffy-convert

Converts SWF animations to HTML, using the Google's Swiffy online converter.



# CLI

Install globally with npm

    $ npm install -g swiffy-convert

Then convert SWF files to HTML:

    swiffy-convert projects/flash-anims/**/*.swf

JSON objects only:

    swiffy-convert projects/flash-anims/**/*.swf -j
    swiffy-convert projects/flash-anims/**/*.swf --json

Don't include the `runtime.js`:

    swiffy-convert projects/flash-anims/**/*.swf -s
    swiffy-convert projects/flash-anims/**/*.swf --skip-runtime

Specify an output directory:

    swiffy-convert projects/flash-anims/**/*.swf -o ~/Desktop
    swiffy-convert projects/flash-anims/**/*.swf --output ~/Desktop

Save to Desktop, as JSON:

    swiffy-convert projects/flash-anims/**/*.swf -jo ~/Desktop


# Node.js

Install on your project

    $ npm install swiffy-convert

Then use it as a module:

    var swiffyConvert = require('swiffy-convert');
    swiffyConvert('path/to/file.swf', {json: false, skipRuntime: false, output: ''}, function(error, body) {
        if (error) {
          return console.log(error);
        }

        console.log('Swiffy HTML:\n' + body);
      });

# License

MIT
