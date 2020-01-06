"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const functions = require("./functions");
function activate(context) {
    let openInputCommand = vscode.commands.registerCommand("pubspec-assist.openInput", functions.openInput);
    context.subscriptions.push(openInputCommand);
}
exports.activate = activate;
// this method is called when your extension is deactivated
function deactivate() {
    console.debug("Pubspec Assist: Deactivated.");
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map