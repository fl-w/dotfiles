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
const path = require("path");
const vscode_1 = require("vscode");
class TreeWalker {
    directories(sourcePath) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                this.ensureFailSafeFileLookup();
                const pattern = new vscode_1.RelativePattern(sourcePath, '**');
                const files = yield vscode_1.workspace.findFiles(pattern, undefined, Number.MAX_VALUE);
                const directories = files.reduce(this.directoryReducer(sourcePath), new Set());
                return this.toSortedArray(directories);
            }
            catch (err) {
                throw new Error(`Unable to list subdirectories for directory "${sourcePath}". Details: (${err.message})`);
            }
        });
    }
    ensureFailSafeFileLookup() {
        process.noAsar = true;
    }
    directoryReducer(sourcePath) {
        return (accumulator, file) => {
            const directory = path.dirname(file.fsPath).replace(sourcePath, '');
            if (directory) {
                accumulator.add(directory);
            }
            return accumulator;
        };
    }
    toSortedArray(directories) {
        return Array
            .from(directories)
            .sort();
    }
}
exports.TreeWalker = TreeWalker;
//# sourceMappingURL=TreeWalker.js.map