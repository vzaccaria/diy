#!/usr/bin/env sh
set -e

# Source directory
#
srcdir=`dirname $0`
srcdir=`cd $srcdir; pwd`
dstdir=`pwd`

bindir=$srcdir/..
npm=$srcdir/../node_modules/.bin

platform=`node -e 'console.log(require("os").platform());'`

for f in $srcdir/$platform/*
do
	# is it a directory?
	if [ -d "$f" ]; then
		$f/run.sh
	fi
done

for f in $srcdir/common/*
do
	# is it a directory?
	if [ -d "$f" ]; then
		$f/run.sh
	fi
done
