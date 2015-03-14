"use strict";

var rewire = require("rewire");

var x = 0;
var y = 0;

var injectTestDeps = function (mod) {

    mod.__set__("uid", function () {
        x = x + 1;
        return x;
    });

    mod.__set__("moment", function () {
        return {
            format: function () {
                return "";
            }
        };
    });
};

var file = rewire("../../../lib/file");
injectTestDeps(file);

var tree = rewire("../../../lib/tree");
injectTestDeps(tree);

var webPack = rewire("../../../lib/packs/web");
injectTestDeps(webPack);

var make = rewire("../../../lib/backends/make");
injectTestDeps(make);

var transcript = make.transcript;
var parse = tree.parse;

var f = parse(function (_) {
    _.addPack(webPack);
    _.collect("all", function (_) {
        _.mirrorTo("./lib", {
            strip: "src/"
        }, function (_) {
            _.collect("build", function (_) {
                _.minify(function (_) {
                    _.livescript("src/*.ls", "src/packs/*.ls", "src/backends/*.ls");
                    _.livescript("src/*.ls");
                    _.concat(function (_) {
                        _.copy("src/*.js6");
                    });
                });
            });
        });

        _.collect("update", function (_) {
            _.cmd("echo 'updated'");
        });

        _.toFile("./index.js", function (_) {
            _.minify(function (_) {
                _.livescript("src/index.ls");
            });
            _.copy("src/index.ls");
        });
    });
});

transcript(f);
