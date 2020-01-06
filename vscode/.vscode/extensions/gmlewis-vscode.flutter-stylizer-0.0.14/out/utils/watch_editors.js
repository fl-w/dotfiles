"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const update_statusbar_1 = require("./update_statusbar");
const watchEditors = (buttons) => {
    vscode.window.onDidChangeActiveTextEditor((editor) => {
        update_statusbar_1.default(editor, buttons);
    });
};
exports.default = watchEditors;
//# sourceMappingURL=watch_editors.js.map