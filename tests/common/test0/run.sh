#!/usr/bin/env sh
set -e

# Source directory
#
srcdir=$(dirname "$0")
srcdir=$(cd "$srcdir"; pwd)

bindir=$srcdir/../../..
npm=$bindir/node_modules/.bin

cd "$srcdir"
rm -f "$srcdir/makefile"
rm -f "$srcdir/output"
node "$srcdir/test0.js"
mv "$srcdir/makefile" "$srcdir/output"
"$npm/diff-files" -m "Test compile, map and reduce" "$srcdir/output" "$srcdir/reference"
