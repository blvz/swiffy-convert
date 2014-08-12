name: \swiffy-convert
version: \0.3.0
description: 'Converts SWF animations to HTML, using the Google\'s Swiffy online converter.'

homepage: 'https://github.com/blvz/swiffy-convert'
keywords: <[ adobe flash swf google swiffy ]>
repository:
  type: 'git'
  url: 'https://github.com/blvz/swiffy-convert.git'

bin:
  'swiffy-convert': './bin/swiffy-convert'

scripts:
  prepublish: 'make package.json'

dependencies:
  cli:        '^0.6'
  glob:       '^4'
  colors:     '^0.6'
  request:    '^2.40'
  LiveScript: '^1.2'

author: 'Rafael Belvederese <rafael@blvz.im>'
license: 'MIT'
