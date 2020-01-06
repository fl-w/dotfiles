"use strict";
var __extends = (this && this.__extends) || function (d, b) {
    for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p];
    function __() { this.constructor = d; }
    d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
};
var vscode = require('vscode');
var abstractProvider_1 = require('./abstractProvider');
function toCompletionItemKind(kind) {
    if (kind == vscode.SymbolKind.Variable) {
        return vscode.CompletionItemKind.Variable;
    }
    else if (kind == vscode.SymbolKind.Function) {
        return vscode.CompletionItemKind.Function;
    }
    else if (kind == vscode.SymbolKind.Class) {
        return vscode.CompletionItemKind.Class;
    }
    else if (kind == vscode.SymbolKind.Enum) {
        return vscode.CompletionItemKind.Enum;
    }
    else {
        return vscode.CompletionItemKind.Variable;
    }
}
var GlobalCompletionItemProvider = (function (_super) {
    __extends(GlobalCompletionItemProvider, _super);
    function GlobalCompletionItemProvider() {
        _super.apply(this, arguments);
    }
    GlobalCompletionItemProvider.prototype.provideCompletionItems = function (document, position, token) {
        console.log(position);
        var word = document.getText(document.getWordRangeAtPosition(position)).split(/\r?\n/)[0];
        var self = this;
        return this._global.run(['-x', '"^' + word + '.*"'])
            .then(function (output) {
            console.log(output);
            var bucket = new Array();
            if (output != null) {
                output.toString().split(/\r?\n/)
                    .forEach(function (value, index, array) {
                    var result = self._global.parseLine(value);
                    if (result == null)
                        return;
                    var item = new vscode.CompletionItem(result.tag);
                    item.detail = result.info;
                    item.kind = toCompletionItemKind(result.kind);
                    bucket.push(item);
                });
            }
            return bucket;
        });
    };
    return GlobalCompletionItemProvider;
}(abstractProvider_1.default));
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = GlobalCompletionItemProvider;
//# sourceMappingURL=completionItemProvider.js.map