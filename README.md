# diy [![NPM version](https://badge.fury.io/js/diy.svg)](http://badge.fury.io/js/diy)

> do it yourself - build DSL

# install

```shell
npm install diy-build
```

# example
## concatenate and minify javascript files

Assume you have two files (`src/file1.js` and `src/file2.js`) that you want to
concatenate and minify into a single `_site/client.js` file.  Here's how you'd write a DIY (ES6) program for the task at hand:

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

DIY uses a **top-down** approach in which you decompose the construction of each product/target into simpler steps.

Everything begins with the `generateProject` library function. This function
generates the makefile by following the steps indicated in the closure passed as a parameter.

```js
generateProject(_ => {
  _.collect("all",
    ...
```

This will declare a new Make target (`all`) associated with the construction of
a set of products specified in the closure passed to `collect` (think of it as a Grunt task).

You could even have a sequence of `_.collect` to declare multiple targets or even multiple targets nested inside another (to specify nested dependencies):


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

Let's go back to our example. The `_.collect` operation specifies the files that must be built:

```js
_.collect("all", _ => {
  _.toFile( "_site/client.js", _ => {
    ...
```

Here, we are specifying that the `all` target corresponds to the construction of the file `_site/client.js`. In this case,
`_.toFile` receives a closure that constructs the minified concatenation of all `src/*.js`:

```js
_.toFile( "_site/client.js", _ => {
  _.minify( _ => {
    _.concat( _ => {
      _.glob("src/*.js")
      ...
```

**Check out the [docs for additional ways to process files](docs/index.html)**

## makefile generation


To generate the makefile we use `babel` to get ES5:

```bash
babel configure.js | node
```

And here's the [generated makefile](demo/makefile).

The makefile comes with two default targets (`prepare` and `clean`) and all the targets defined with `collect`:

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

What about your favorite CSS/JS preprocessor and other minifiers?

Here's how you would define a new processing step to compile Javascript with a
bunch of Browserify plugins:

```js
_.browserify = (src, ...deps) => {
  var command = (_) => `./node_modules/.bin/browserify -t liveify -t node-lessify  ${_.source} -o ${_.product}`
  var product = (_) => `${_.source.replace(/\..*/, '.bfd.js')}`
  _.compileFiles(...([ command, product, src ].concat(deps)))
}
```

`_.compileFiles` is a built-in function that allows you to easily construct new processing steps. Its first
two parameters are two templates:

1. A function to build the command line; and
2. A function to build the product name.

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

Serving static files from a directory and livereloading upon a change of a product are supported through `pm2` and `tiny-lr`. We can
create two make targets (`start` and `stop`) that start and stop both services:

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

`_.startWatch(glob)` is a built-in step that launches a tiny-lr instance to trigger a reload upon a change in files matching the glob.
`_.startServe(root,port)` serves files from the specified root and port.



## Author

**Vittorio Zaccaria**

+ [github/vzaccaria](https://github.com/vzaccaria)

## License
Copyright (c) 2015 Vittorio Zaccaria  
Released under the  license

***

_This file was generated by [verb-cli](https://github.com/assemble/verb-cli) on March 10, 2015._

