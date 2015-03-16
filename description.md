# install

```shell
npm install diy-build
```

# example
## concatenate and minify javascript files

Assume you have two files (`src/file1.js` and `src/file2.js`) that you want to
concatenate and minify into a single `_site/client.js` file.  Here's how you'd write a Diy (ES6) program for the task at hand:

## diy source file

```js
/* configure.js */

var {
  generateProject
} = require("diy");

generateProject(_ => {
  _.collect("all", _ => {
    _.toFile( "_site/client.js", _ => {
      _.minify( _ => {
        _.concat( _ => {
          _.glob("src/*.js")
        })
      })
    })
  })
})
```

## description

Diy uses a **top-down** approach where you decompose the construction of each product/target into simpler steps.

Everything starts with the `generateProject` library function. This function
generates the makefile by following the steps indicated in the closure passed as parameter.

```js
generateProject(_ => {
  _.collect("all",
    ...
```

In fact, this is like saying: "Hey, my project is composed by a single set of files collectively
called `all`". Indeed, the target "all" will be among the available targets in the generated makefile.

You could even have a sequence of `_.collect`, declaring multiple targets, or even one target nested inside another (to specify nested dependencies):


```js
generateProject(_ => {
  _.collectSeq("all", _ => {
    _.collect("build", _ => {
      /* specify how to build files */
    })
    _.collect("deploy", _ => {
      /* specify how to deploy files */
    }
  })
})
```

But let's go back to our example. The `_.collect` operation specifies what are the files that must be created:

```js
_.collect("all", _ => {
  _.toFile( "_site/client.js", _ => {
    ...
```

This is like saying: "Look, when I say `make all`, I really want to build the file "\_site/client.js".
`_.toFile` instructs make to create a named file whose contents are generated in the nested closure:

```js
_.toFile( "_site/client.js", _ => {
  _.minify( _ => {
    _.concat( _ => {
      _.glob("src/*.js")
      ...
```

Thus the minified concatenation of all `src/*.js` is copied into "_site/client.js".

**Check out the [docs for additional ways to process files](docs/index.html)**

## makefile generation


To generate the makefile we use babel to get ES5:

```bash
babel configure.js | node
```

And here's the [generated makefile](demo/makefile).

The makefile comes with two default targets (`prepare` and `clean`) plus all the targets defined with `collect`:

```bash
> make prepare      # Creates destination directories
> make clean        # Removes all products
> make all          # Execute commands associated with `all`
```

Make provides a way to specify the maximum parallelism to be used for building targets:

```bash
> make all -j 8     # Build all, execute up to 8 concurrent commands.
```



# customization

What about your favorite css/js preprocessor and other minifiers?

Here's how you would define a new processing step to compile javascript with a
bunch of browserify plugins:

```js
_.browserify = (src, ...deps) => {
  var command = (_) => `./node_modules/.bin/browserify -t liveify -t node-lessify  ${_.source} -o ${_.product}`
  var product = (_) => `${_.source.replace(/\..*/, '.bfd.js')}`
  _.compileFiles(...([ command, product, src ].concat(deps)))
}
```

`_.compileFiles` is a built in function to easily construct new processing steps. Its first
two parameters are two templates:

1. a function to build the command line
2. a function to build the product name

The remaining parameters are `src` (glob for the source files) and the source dependencies.

```js
generateProject(_ => {

  _.browserify = (dir, ...deps) => {
    var command = (_) => `./node_modules/.bin/browserify -t liveify -t node-lessify  ${_.source} -o ${_.product}`
    var product = (_) => `${_.source.replace(/\..*/, '.bfd.js')}`
    _.compileFiles(...([ command, product, dir ].concat(deps)))
  }

  _.collect("all", _ => {
    _.toFile( "_site/client.js", _ => {
        _.browserify("src/index.ls", "src/**/*.less", "src/**/*.ls")
    })
  })
}
```

# serving and livereloading

Serving static files from a directory and livereloading upon a change of a product is supported through `pm2` and `tiny-lr`. We can
create two make targets (`start` and `stop`) that take care of starting and stopping both services:

```js
generateProject(_ => {

    /* ... */

  _.collect("start", _ => {
    _.startWatch("_site/**/*")
    _.startServe("_site")
  })

  _.collect("stop", _ => {
    _.stopWatch()
    _.stopServe()
  })

    /* ... */
})
```

`_.startWatch(glob)` is a built-in step that launches a tiny-lr instance that triggers a reload upon change on files matching the glob.
`_.startServe(root,port)` serves files from the specified root and port.
