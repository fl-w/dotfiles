"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const command_1 = require("./command");
const controller_1 = require("./controller");
function handleError(err) {
    if (err && err.message) {
        vscode.window.showErrorMessage(err.message);
    }
    return err;
}
function register(context, command, commandName) {
    const proxy = (...args) => command.execute(...args).catch(handleError);
    const disposable = vscode.commands.registerCommand(`fileutils.${commandName}`, proxy);
    context.subscriptions.push(disposable);
}
function activate(context) {
    const moveFileController = new controller_1.MoveFileController(context);
    const newFileController = new controller_1.NewFileController(context);
    const duplicateFileController = new controller_1.DuplicateFileController(context);
    const removeFileController = new controller_1.RemoveFileController(context);
    const copyFileNameController = new controller_1.CopyFileNameController(context);
    register(context, new command_1.MoveFileCommand(moveFileController), 'moveFile');
    register(context, new command_1.RenameFileCommand(moveFileController), 'renameFile');
    register(context, new command_1.DuplicateFileCommand(duplicateFileController), 'duplicateFile');
    register(context, new command_1.RemoveFileCommand(removeFileController), 'removeFile');
    register(context, new command_1.NewFileCommand(newFileController), 'newFile');
    register(context, new command_1.NewFileAtRootCommand(newFileController), 'newFileAtRoot');
    register(context, new command_1.NewFolderCommand(newFileController), 'newFolder');
    register(context, new command_1.NewFolderAtRootCommand(newFileController), 'newFolderAtRoot');
    register(context, new command_1.CopyFileNameCommand(copyFileNameController), 'copyFileName');
}
exports.activate = activate;
//# sourceMappingURL=extension.js.map