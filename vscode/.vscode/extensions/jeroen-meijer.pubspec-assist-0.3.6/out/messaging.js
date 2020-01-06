"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
var ErrorOptionType;
(function (ErrorOptionType) {
    ErrorOptionType["report"] = "Report issue";
    ErrorOptionType["ignore"] = "Ignore";
})(ErrorOptionType || (ErrorOptionType = {}));
let errorOptions = [
    { title: ErrorOptionType.report },
    { title: ErrorOptionType.ignore }
];
function showInfo(message) {
    return vscode.window.showInformationMessage(`Pubspec Assist: ${message}`);
}
exports.showInfo = showInfo;
function showError(error, isCritical = false) {
    let message = "Pubspec Assist: ";
    if (!isCritical) {
        message += error.message;
        vscode.window.showErrorMessage(message);
        return;
    }
    message += `
      Error occurred.\n
      Type: "${error.name}"
      Message: "${error.message}"
      `;
    vscode.window
        .showErrorMessage(message, {}, ...errorOptions)
        .then(handleErrorResponse);
}
exports.showError = showError;
function handleErrorResponse(option) {
    if (option) {
        switch (option) {
            case ErrorOptionType.report:
            default:
                break;
        }
    }
}
function showCriticalError(error) {
    return showError(error, true);
}
exports.showCriticalError = showCriticalError;
//# sourceMappingURL=messaging.js.map