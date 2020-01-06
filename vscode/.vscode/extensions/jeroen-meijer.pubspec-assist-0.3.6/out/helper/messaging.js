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
const vscode = require("vscode");
const web_1 = require("./web");
var ErrorOptionType;
(function (ErrorOptionType) {
    ErrorOptionType["report"] = "Report issue";
    ErrorOptionType["ignore"] = "Ignore";
    ErrorOptionType["tryAgain"] = "Try Again";
    ErrorOptionType["close"] = "Close";
})(ErrorOptionType || (ErrorOptionType = {}));
let criticalErrorOptions = [
    { title: ErrorOptionType.report },
    { title: ErrorOptionType.ignore }
];
let retryableErrorOptions = [
    { title: ErrorOptionType.tryAgain },
    { title: ErrorOptionType.close }
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
    message += `A critical error has occurred.\n
    If this happens again, please report it.\n\n
    
    Error message: ${error.message}`;
    vscode.window
        .showErrorMessage(message, {}, ...criticalErrorOptions)
        .then((option) => {
        if (option) {
            handleErrorOptionResponse(option.title, error);
        }
    });
}
exports.showError = showError;
function showRetryableError(error) {
    return __awaiter(this, void 0, void 0, function* () {
        let message = "Pubspec Assist: ";
        message += `An error has occurred:\n${error.message}`;
        const response = yield vscode.window.showWarningMessage(message, {}, ...retryableErrorOptions);
        return !!response && response.title === ErrorOptionType.tryAgain;
    });
}
exports.showRetryableError = showRetryableError;
function handleErrorOptionResponse(option, error) {
    switch (option) {
        case ErrorOptionType.report:
            web_1.openNewGitIssueUrl(error);
            break;
        default:
            break;
    }
}
function showCriticalError(error) {
    showError(error, true);
}
exports.showCriticalError = showCriticalError;
//# sourceMappingURL=messaging.js.map