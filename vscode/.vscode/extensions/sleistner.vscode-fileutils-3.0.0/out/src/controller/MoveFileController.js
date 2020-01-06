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
const FileItem_1 = require("../FileItem");
const BaseFileController_1 = require("./BaseFileController");
class MoveFileController extends BaseFileController_1.BaseFileController {
    showDialog(options) {
        return __awaiter(this, void 0, void 0, function* () {
            const { prompt, showFullPath = false, uri = null } = options;
            const sourcePath = uri && uri.fsPath || (yield this.getSourcePath());
            if (!sourcePath) {
                throw new Error();
            }
            const value = showFullPath ? sourcePath : path.basename(sourcePath);
            const valueSelection = this.getFilenameSelection(value);
            const targetPath = yield vscode_1.window.showInputBox({ prompt, value, valueSelection });
            if (targetPath) {
                const realPath = path.resolve(path.dirname(sourcePath), targetPath);
                return new FileItem_1.FileItem(sourcePath, realPath);
            }
        });
    }
    execute(options) {
        return __awaiter(this, void 0, void 0, function* () {
            const { fileItem } = options;
            yield this.ensureWritableFile(fileItem);
            return fileItem.move();
        });
    }
    getFilenameSelection(value) {
        const basename = path.basename(value);
        const start = value.length - basename.length;
        const dot = basename.lastIndexOf('.');
        const exclusiveEndIndex = dot <= 0 ? value.length : start + dot;
        return [start, exclusiveEndIndex];
    }
}
exports.MoveFileController = MoveFileController;
//# sourceMappingURL=MoveFileController.js.map