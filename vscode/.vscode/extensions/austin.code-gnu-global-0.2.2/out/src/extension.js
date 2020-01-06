"use strict";
// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
var vscode = require('vscode');
var global_1 = require('./global');
var completionItemProvider_1 = require('./features/completionItemProvider');
var definitionProvider_1 = require('./features/definitionProvider');
var documentSymbolProvider_1 = require('./features/documentSymbolProvider');
var referenceProvider_1 = require('./features/referenceProvider');
// this method is called when your extension is activated
// your extension is activated the very first time the command is executed
function activate(context) {
    // Use the console to output diagnostic information (console.log) and errors (console.error)
    // This line of code will only be executed once when your extension is activated
    console.log('Congratulations, your extension "code-gnu-global" is now active!');
    var configuration = vscode.workspace.getConfiguration('codegnuglobal');
    var executable = configuration.get('executable', 'global');
    var global = new global_1.Global(executable);
    context.subscriptions.push(vscode.languages.registerCompletionItemProvider(['cpp', 'c'], new completionItemProvider_1.default(global), '.', '>'));
    context.subscriptions.push(vscode.languages.registerDefinitionProvider(['cpp', 'c'], new definitionProvider_1.default(global)));
    context.subscriptions.push(vscode.languages.registerDocumentSymbolProvider(['cpp', 'c'], new documentSymbolProvider_1.default(global)));
    context.subscriptions.push(vscode.languages.registerReferenceProvider(['cpp', 'c'], new referenceProvider_1.default(global)));
    context.subscriptions.push(vscode.workspace.onDidSaveTextDocument(function (d) { return global.updateTags(); }));
}
exports.activate = activate;
//# sourceMappingURL=extension.js.map