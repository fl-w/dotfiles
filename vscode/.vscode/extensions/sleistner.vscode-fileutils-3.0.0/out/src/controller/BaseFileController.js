"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const Cache_1 = require("../lib/Cache");
class BaseFileController {
    constructor(context) {
        this.context = context;
    }
    openFileInEditor(fileItem) {
        return __awaiter(this, void 0, void 0, function* () {
            if (fileItem.isDir) {
                return;
            }
            const textDocument = yield vscode_1.workspace.openTextDocument(fileItem.path);
            if (!textDocument) {
                throw new Error('Could not open file!');
            }
            const editor = yield vscode_1.window.showTextDocument(textDocument, vscode_1.ViewColumn.Active);
            if (!editor) {
                throw new Error('Could not show document!');
            }
            return editor;
        });
    }
    closeCurrentFileEditor() {
        return __awaiter(this, void 0, void 0, function* () {
            return vscode_1.commands.executeCommand('workbench.action.closeActiveEditor');
        });
    }
    getSourcePath(options) {
        return __awaiter(this, void 0, void 0, function* () {
            // Attempting to get the fileName from the activeTextEditor.
            // Works for text files only.
            const activeEditor = vscode_1.window.activeTextEditor;
            if (activeEditor && activeEditor.document && activeEditor.document.fileName) {
                return activeEditor.document.fileName;
            }
            // No activeTextEditor means that we don't have an active file or
            // the active file is a non-text file (e.g. binary files such as images).
            // Since there is no actual API to differentiate between the scenarios, we try to retrieve
            // the path for a non-textual file before throwing an error.
            const sourcePath = this.getSourcePathForNonTextFile();
            if (!sourcePath) {
                throw new Error();
            }
            return sourcePath;
        });
    }
    getCache(namespace) {
        return new Cache_1.Cache(this.context.globalState, namespace);
    }
    ensureWritableFile(fileItem) {
        return __awaiter(this, void 0, void 0, function* () {
            if (!fileItem.exists) {
                return fileItem;
            }
            if (fileItem.targetPath === undefined) {
                throw new Error('Missing target path');
            }
            const message = `File '${fileItem.targetPath.path}' already exists.`;
            const action = 'Overwrite';
            const overwrite = yield vscode_1.window.showInformationMessage(message, { modal: true }, action);
            if (overwrite) {
                return fileItem;
            }
            throw new Error();
        });
    }
    getSourcePathForNonTextFile() {
        return __awaiter(this, void 0, void 0, function* () {
            // Since there is no API to get details of non-textual files, the following workaround is performed:
            // 1. Saving the original clipboard data to a local variable.
            const originalClipboardData = yield vscode_1.env.clipboard.readText();
            // 2. Populating the clipboard with an empty string
            yield vscode_1.env.clipboard.writeText('');
            // 3. Calling the copyPathOfActiveFile that populates the clipboard with the source path of the active file.
            // If there is no active file - the clipboard will not be populated and it will stay with the empty string.
            yield vscode_1.commands.executeCommand('workbench.action.files.copyPathOfActiveFile');
            // 4. Get the clipboard data after the API call
            const postAPICallClipboardData = yield yield vscode_1.env.clipboard.readText();
            // 5. Return the saved original clipboard data to the clipboard so this method
            // will not interfere with the clipboard's content.
            yield vscode_1.env.clipboard.writeText(originalClipboardData);
            // 6. Return the clipboard data from the API call (which could be an empty string if it failed).
            return postAPICallClipboardData;
        });
    }
}
exports.BaseFileController = BaseFileController;
//# sourceMappingURL=BaseFileController.js.map