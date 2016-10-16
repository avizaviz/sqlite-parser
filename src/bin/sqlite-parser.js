var parser = require('../lib/index');
var argv = process.argv.slice(2);
var fs = require('fs');
var path = require('path');

var args = { _: [] };
var last = null;
argv.forEach(function (arg, i) {
  if (arg.indexOf('-') === 0) {
    if (last) {
      args[last] = true;
    }
    const cur = arg.slice(2);
    if (i === argv.length - 1) {
      args[cur] = true;
    } else {
      last = cur;
    }
  } else if (last) {
    args[last] = arg;
    last = null;
  } else {
    args._.push(arg);
  }
});

if (args['help']) {
  console.log(`Usage: sqlite-parser infile [--output outfile]`);
  process.exit(0);
}

if (args['version']) {
  console.log(`sqlite-parser v@@VERSION`);
  process.exit(0);
}

if (args._.length === 0) {
  throw new Error('No input filename specified.');
}

var input = path.normalize(args._[0]);
var output = args['o'] || args['output'];

if (output) {
  output = path.normalize(output);
}

fs.stat(input, startCallback);

function error(err) {
  console.error(err.message);
  process.exit(1);
}

function writeOut(result, outPath) {
  var outDir = path.dirname(outPath);

  function writeCallback(err) {
    if (err) { return error(err) }
    // done
    console.log(`Wrote ${outPath}`);
    process.exit(0);
  }

  function mkdirCallback(err) {
    if (err) { return error(err) }
    fs.writeFile(outPath, result, writeCallback);
  }

  function statCallback(err) {
    if (err) {
      return fs.mkdir(outDir, mkdirCallback);
    }
    mkdirCallback();
  }

  fs.stat(outDir, statCallback);
}

function parserCallback(err, ast) {
  if (err) { return error(err) }
  var result = JSON.stringify(ast, null, 2);

  if (output) {
    writeOut(result, output);
  } else {
    process.stdout.write(result);
    process.exit(0);
  }
}

function readCallback(err, data) {
  if (err) { return error(err) }
  parser(data, parserCallback);
}

function startCallback(err) {
  if (err) { return error(err); }
  fs.readFile(input, 'utf8', readCallback);
}