name: \swiffy-convert
version: \1.2.1
description: 'Converts SWF animations to HTML, using
            \ Google\'s Swiffy online converter.'

engines:
  node: '>=0.10'

homepage: 'https://github.com/blvz/swiffy-convert'
keywords: <[ adobe flash swf google swiffy ]>
repository:
  type: 'git'
  url: 'https://github.com/blvz/swiffy-convert.git'

bin:
  'swiffy-convert': './bin/swiffy-convert'

scripts:
  prepublish: 'make metadata'
  test: 'make test'

files: <[ bin lib index.js ]>

dependencies:
  cli:         '^0.6'
  glob:          '^4'
  colors:      '^0.6'
  request:    '^2.40'

dev-dependencies:
  vows:       '^0.8.1'
  'vows-at':  '^0.0.1'
  LiveScript:   '^1.3'

author: 'Rafael Belvederese <rafael@blvz.im>'
license: 'MIT'
