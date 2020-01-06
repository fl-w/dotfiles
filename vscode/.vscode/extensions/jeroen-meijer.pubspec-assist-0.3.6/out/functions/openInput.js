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
const messaging_1 = require("../helper/messaging");
const pubApi_1 = require("../model/pubApi");
const pubError_1 = require("../model/pubError");
const js_yaml_1 = require("js-yaml");
const util_1 = require("util");
const getValue_1 = require("../helper/getValue");
var InsertionMethod;
(function (InsertionMethod) {
    InsertionMethod["ADD"] = "Added";
    InsertionMethod["REPLACE"] = "Replaced";
})(InsertionMethod = exports.InsertionMethod || (exports.InsertionMethod = {}));
function openInput(context) {
    return __awaiter(this, void 0, void 0, function* () {
        const api = new pubApi_1.PubAPI();
        if (!vscode.window.activeTextEditor || !pubspecFileIsOpen()) {
            messaging_1.showError(new pubError_1.PubError("Pubspec file not opened."));
            return;
        }
        const query = yield askPackageName();
        if (!query) {
            return;
        }
        const searchingMessage = setMessage(`Looking for package '${query}'...`);
        let res = yield getValue_1.getValue(() => api.smartSearchPackage(query));
        if (!res) {
            return;
        }
        const searchResult = res.result;
        searchingMessage.dispose();
        if (searchResult.packages.length === 0) {
            messaging_1.showInfo(`Package with name '${query}' not found.`);
            return;
        }
        const chosenPackageString = searchResult.packages.length === 1
            ? searchResult.packages[0]
            : yield selectFrom(searchResult.packages);
        if (!chosenPackageString) {
            return;
        }
        const gettingPackageMessage = setMessage(`Getting info for package '${chosenPackageString}'...`);
        let chosenPackageResponse = yield getValue_1.getValue(() => api.getPackage(chosenPackageString));
        if (!chosenPackageResponse) {
            return;
        }
        gettingPackageMessage.dispose();
        const chosenPackage = chosenPackageResponse.result;
        try {
            const preserveNewline = checkNewlineAtEndOfFile();
            formatDocument();
            const pubspecString = getActiveEditorText();
            const originalLines = pubspecString.split("\n");
            const modifiedPubspec = addDependencyByText(pubspecString, chosenPackage);
            const newPubspecString = modifiedPubspec.result.concat(preserveNewline ? "\n" : "");
            vscode.window.activeTextEditor.edit(editBuilder => {
                editBuilder.replace(new vscode.Range(new vscode.Position(0, 0), new vscode.Position(originalLines.length - 1, originalLines[originalLines.length - 1].length)), newPubspecString);
            });
            messaging_1.showInfo(`${modifiedPubspec.insertionMethod.toString()} '${chosenPackage.name}' (version ${chosenPackage.latestVersion}).`);
        }
        catch (error) {
            messaging_1.showCriticalError(error);
        }
    });
}
exports.openInput = openInput;
function getActiveEditorText() {
    const activeEditor = vscode.window.activeTextEditor;
    if (activeEditor) {
        return activeEditor.document.getText();
    }
    return "";
}
exports.getActiveEditorText = getActiveEditorText;
function checkNewlineAtEndOfFile() {
    return getActiveEditorText().substr(-1) === "\n";
}
exports.checkNewlineAtEndOfFile = checkNewlineAtEndOfFile;
function pubspecFileIsOpen() {
    return (vscode.window.activeTextEditor &&
        (vscode.window.activeTextEditor.document.fileName.endsWith("pubspec.yaml") ||
            vscode.window.activeTextEditor.document.fileName.endsWith("pubspec.yml")));
}
exports.pubspecFileIsOpen = pubspecFileIsOpen;
function addDependencyByText(pubspecString, newPackage) {
    let insertionMethod = InsertionMethod.ADD;
    let lines = pubspecString.split("\n");
    let dependencyLineIndex = lines.findIndex(line => line.trim() === "dependencies:");
    if (dependencyLineIndex === -1) {
        lines.push("dependencies:");
        dependencyLineIndex = lines.length - 1;
    }
    if (dependencyLineIndex === lines.length - 1) {
        lines.push("");
    }
    const existingPackageLineIndex = lines.findIndex(line => {
        if (!line.includes(":")) {
            return false;
        }
        const sanitizedLine = line.trim();
        const colonIndex = sanitizedLine.indexOf(":");
        const potentialMatch = sanitizedLine.substring(0, colonIndex);
        return potentialMatch.trim() === newPackage.name;
    });
    if (existingPackageLineIndex !== -1) {
        const originalLine = lines[existingPackageLineIndex];
        lines[existingPackageLineIndex] =
            "  " + newPackage.generateDependencyString();
        if (originalLine.includes("\r")) {
            lines[existingPackageLineIndex] += "\r";
        }
        if (originalLine.includes("\n")) {
            lines[existingPackageLineIndex] += "\n";
        }
        insertionMethod = InsertionMethod.REPLACE;
    }
    else {
        for (let i = dependencyLineIndex + 1; i < lines.length; i++) {
            if (!lines[i].startsWith(" ") && !lines[i].trim().startsWith("#")) {
                lines[i] =
                    "  " + newPackage.generateDependencyString() + "\r\n" + lines[i];
                break;
            }
            if (i === lines.length - 1) {
                if (!lines[i].includes("\r")) {
                    lines[i] = lines[i] + "\r";
                }
                lines.push("  " + newPackage.generateDependencyString());
                break;
            }
        }
    }
    pubspecString = lines
        .join("\n")
        .split("\n")
        // .map((line, index) => (!(line[0] === " ") ? "\n" + line : line))
        .join("\n")
        .trim();
    return { insertionMethod: insertionMethod, result: pubspecString };
}
exports.addDependencyByText = addDependencyByText;
util_1.deprecate(addDependencyByObject, "Currently using `addDependenctByText` instead.");
function addDependencyByObject(pubspecString, newPackage) {
    let pubspec = js_yaml_1.safeLoad(pubspecString);
    if (!pubspec) {
        pubspec = {};
    }
    if (!pubspec.dependencies) {
        pubspec.dependencies = {};
    }
    pubspec.dependencies[newPackage.name] = `^${newPackage.latestVersion}`;
    return js_yaml_1.safeDump(pubspec);
}
exports.addDependencyByObject = addDependencyByObject;
function askPackageName() {
    return vscode.window.showInputBox({
        prompt: "Enter the package name.",
        placeHolder: `Package name (cloud_firestore, get_it, ...)`
    });
}
exports.askPackageName = askPackageName;
function setMessage(message) {
    return vscode.window.setStatusBarMessage(`$(pencil) Pubspec Assists: ${message}`);
}
exports.setMessage = setMessage;
function selectFrom(options) {
    return vscode.window.showQuickPick(options, {
        canPickMany: false,
        matchOnDescription: true
    });
}
exports.selectFrom = selectFrom;
function formatDocument() {
    vscode.commands.executeCommand("editor.action.formatDocument");
}
exports.formatDocument = formatDocument;
exports.default = openInput;
//# sourceMappingURL=openInput.js.map