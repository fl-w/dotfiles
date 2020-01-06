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
const fs = require("fs");
const path = require("path");
const vscode_1 = require("vscode");
class FileItem {
    constructor(sourcePath, targetPath, IsDir = false) {
        this.IsDir = IsDir;
        this.SourcePath = this.toUri(sourcePath);
        if (targetPath !== undefined) {
            this.TargetPath = this.toUri(targetPath);
        }
    }
    get name() {
        return path.basename(this.SourcePath.path);
    }
    get path() {
        return this.SourcePath;
    }
    get targetPath() {
        return this.TargetPath;
    }
    get exists() {
        if (this.targetPath === undefined) {
            return false;
        }
        return fs.existsSync(this.targetPath.fsPath);
    }
    get isDir() {
        return this.IsDir;
    }
    move() {
        return __awaiter(this, void 0, void 0, function* () {
            this.ensureTargetPath();
            yield vscode_1.workspace.fs.rename(this.path, this.targetPath, { overwrite: true });
            this.SourcePath = this.targetPath;
            return this;
        });
    }
    duplicate() {
        return __awaiter(this, void 0, void 0, function* () {
            this.ensureTargetPath();
            yield vscode_1.workspace.fs.copy(this.path, this.targetPath, { overwrite: true });
            return new FileItem(this.targetPath);
        });
    }
    remove(useTrash = false) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                yield vscode_1.workspace.fs.delete(this.path, { recursive: true, useTrash });
            }
            catch (err) {
                if (useTrash === true && err instanceof vscode_1.FileSystemError) {
                    return this.remove(false);
                }
                throw err;
            }
            return this;
        });
    }
    create(mkDir) {
        return __awaiter(this, void 0, void 0, function* () {
            this.ensureTargetPath();
            yield vscode_1.workspace.fs.delete(this.targetPath, { recursive: true });
            if (mkDir === true || this.isDir) {
                yield vscode_1.workspace.fs.createDirectory(this.targetPath);
            }
            else {
                yield vscode_1.workspace.fs.writeFile(this.targetPath, new Uint8Array());
            }
            return new FileItem(this.targetPath);
        });
    }
    ensureTargetPath() {
        if (this.targetPath === undefined) {
            throw new Error('Missing target path');
        }
    }
    toUri(uriOrString) {
        return uriOrString instanceof vscode_1.Uri ? uriOrString : vscode_1.Uri.file(uriOrString);
    }
}
exports.FileItem = FileItem;
//# sourceMappingURL=FileItem.js.map