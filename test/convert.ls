require! {
  fs, vows
  'vows-at': at
  '../lib/convert'
}

function stringfile then (.to-string!) <| fs.read-file-sync it

describe = vows~describe

describe 'Swiffy Convert'
  ..add-batch {
    'A SWF stream':
      topic: -> fs.create-read-stream 'test/fixtures/5039_buttonsfade.swf'

      'when converted':
        topic: -> convert it, @callback

        'should include the status': at ->
          @include \status

        'the status': at ->
          topic: (.status)
          'should be successful': at ->
            @equal \SUCCESS

        'should include outputs': at ->
          @include \output

        'the output':
          topic: (.output)
          'should include both HTML and JSON': at ->
            @include \html
            @include \json

          'the HTML':
            topic: (.html)
            'should be valid': at ->
              @equal stringfile 'test/fixtures/5039_buttonsfade.swf.html'

          'the JSON':
            topic: (.json)
            'should be valid': at ->
              @equal stringfile 'test/fixtures/5039_buttonsfade.swf.json'

        'should include messages': at ->
          @include \messages

        'should include a warning':
          topic: (.messages.0.description)

          'for sound incompatibility': at ->
            @equal 'The ActionScript property
                  \ flash.display.Sprite.soundTransform is not supported.'

    'A SWF buffer':
      topic: -> fs.read-file-sync 'test/fixtures/5039_buttonsfade.swf'

      'when converted':
        topic: -> convert it, @callback

        'should include the status': at ->
          @include \status

        'the status': at ->
          topic: (.status)
          'should be successful': at ->
            @equal \SUCCESS

    'A SWF path':
      topic: 'test/fixtures/5039_buttonsfade.swf'

      'when converted':
        topic: -> convert it, @callback

        'should include the status': at ->
          @include \status

        'the status': at ->
          topic: (.status)
          'should be successful': at ->
            @equal \SUCCESS
  }
  ..export module
