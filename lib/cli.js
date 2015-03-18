// Generated by LiveScript 1.3.1
(function(){
  var fs, cli, colors, convert, NUM_TRIES, count, total, files, replace$ = ''.replace;
  fs = require('fs');
  cli = require('cli');
  colors = require('colors');
  convert = require('./convert');
  cli = cli.enable('glob');
  cli.parse({
    skipRuntime: ['s', 'Don\'t include the `runtime.js` on the HTML files'],
    json: ['j', 'Save the converted SWF files as JSON only.']
  });
  NUM_TRIES = 3;
  count = 0;
  total = 0;
  files = [];
  cli.main(function(args, options){
    var i$, to$, results$ = [];
    files = args.concat().map(function(it){
      return {
        tries: 0,
        path: it
      };
    });
    total = files.length;
    console.log('');
    for (i$ = 0, to$ = Math.min(files.length, 10); i$ < to$; ++i$) {
      results$.push(convertFile(options));
    }
    return results$;
  });
  function convertFile(options){
    var file, ref$, path, parent, name, ext, output;
    file = files.shift();
    ref$ = /^(.+)\/([^\/]*)$/.exec(file.path), path = ref$[0], parent = ref$[1], name = ref$[2];
    ext = options.json ? 'json' : 'html';
    output = parent + "/" + name + "." + ext;
    file.tries++;
    return convert(path, function(err, obj){
      var ref$, html, json, i$, len$, msg;
      if (err) {
        console.error("Error converting " + file.path + "\ on try " + file.tries + "/" + NUM_TRIES + ":");
        console.error(err + '\n');
        if (file.tries < NUM_TRIES) {
          files.push(file);
        }
        return;
      }
      ref$ = obj.output, html = ref$.html, json = ref$.json;
      if (options.skipRuntime) {
        html = replace$.call(html, /<script.+runtime\.js.+<\/script>/, '');
      }
      fs.writeFileSync(output, options.json ? json : html);
      console.log(("[" + (++count) + " of " + total + "] ").green + output);
      if (obj.messages) {
        for (i$ = 0, len$ = (ref$ = obj.messages).length; i$ < len$; ++i$) {
          msg = ref$[i$];
          console.log(("[ " + msg.type + " ] ").yellow + msg.description);
        }
        console.log('');
      }
      if (files.length) {
        return convertFile(options);
      }
    });
  }
}).call(this);