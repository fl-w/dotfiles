"use strict";
var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var vscode = require('vscode');
var abstractProvider_1 = require('./abstractProvider');
var GlobalReferenceProvider = (function (_super) {
    __extends(GlobalReferenceProvider, _super);
    function GlobalReferenceProvider() {
        _super.apply(this, arguments);
    }
    GlobalReferenceProvider.prototype.provideReferences = function (document, position, options, token) {
        console.log(position);
        var word = document.getText(document.getWordRangeAtPosition(position)).split(/\r?\n/)[0];
        var self = this;
        return this._global.run(['--encode-path', '" "', '-rax', word])
            .then(function (output) {
            console.log(output);
            var bucket = new Array();
            try {
                if (output != null) {
                    output.toString().split(/\r?\n/)
                        .forEach(function (value, index, array) {
                        var result = self._global.parseLine(value);
                        if (result == null)
                            return;
                        bucket.push(new vscode.Location(vscode.Uri.file(result.path), new vscode.Range(new vscode.Position(result.line, 0), new vscode.Position(result.line, 0))));
                    });
                }
            }
            catch (ex) {
                console.error("Error: " + ex);
            }
            return bucket;
        });
    };
    return GlobalReferenceProvider;
}(abstractProvider_1.default));
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = GlobalReferenceProvider;
//# sourceMappingURL=referenceProvider.js.map