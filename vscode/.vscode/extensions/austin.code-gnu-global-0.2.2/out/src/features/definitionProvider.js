"use strict";
var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var vscode = require('vscode');
var abstractProvider_1 = require('./abstractProvider');
var GlobalDefinitionProvider = (function (_super) {
    __extends(GlobalDefinitionProvider, _super);
    function GlobalDefinitionProvider() {
        _super.apply(this, arguments);
    }
    GlobalDefinitionProvider.prototype.provideDefinition = function (document, position, token) {
        console.log(position);
        var word = document.getText(document.getWordRangeAtPosition(position)).split(/\r?\n/)[0];
        var self = this;
        return this._global.run(['--encode-path', '" "', '-xa', word])
            .then(function (output) {
            console.log(output);
            try {
                var bucket = new Array();
                if (output != null) {
                    output.toString().split(/\r?\n/)
                        .forEach(function (value, index, array) {
                        var result = self._global.parseLine(value);
                        if (result == null)
                            return;
                        result.label = result.path;
                        result.description = result.info;
                        console.log(result.path);
                        bucket.push(result);
                    });
                }
                if (bucket.length == 1) {
                    return new vscode.Location(vscode.Uri.file(bucket[0].path), new vscode.Position(bucket[0].line, 0));
                }
                else if (bucket.length == 0) {
                    return null;
                }
                var matches = new Array();
                bucket.forEach(function (value, index, array) {
                    matches.push(new vscode.Location(vscode.Uri.file(value.path), new vscode.Position(value.line, 0)));
                });
                return matches;
            }
            catch (ex) {
                console.error("Error: " + ex);
            }
            return null;
        });
    };
    return GlobalDefinitionProvider;
}(abstractProvider_1.default));
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = GlobalDefinitionProvider;
//# sourceMappingURL=definitionProvider.js.map