#!/usr/bin/env sh
set -e

# Source directory
#
srcdir=`dirname $0`
srcdir=`cd $srcdir; pwd`
dstdir=`pwd`

bindir=$srcdir/../../..
npm=$bindir/node_modules/.bin

cd $srcdir
node $bindir/lib/test/test3.js
mv $srcdir/makefile $srcdir/output
$npm/diff-files -m "Copy js files should work" $srcdir/output $srcdir/reference
