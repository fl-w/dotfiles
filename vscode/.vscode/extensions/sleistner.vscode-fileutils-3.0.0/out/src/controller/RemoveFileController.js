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
const config_1 = require("../lib/config");
const BaseFileController_1 = require("./BaseFileController");
class RemoveFileController extends BaseFileController_1.BaseFileController {
    showDialog() {
        return __awaiter(this, void 0, void 0, function* () {
            const sourcePath = yield this.getSourcePath();
            if (!sourcePath) {
                throw new Error();
            }
            if (this.confirmDelete === false) {
                return new FileItem_1.FileItem(sourcePath);
            }
            const message = `Are you sure you want to delete '${path.basename(sourcePath)}'?`;
            const action = this.useTrash ? 'Move to Trash' : 'Delete';
            const remove = yield vscode_1.window.showInformationMessage(message, { modal: true }, action);
            if (remove) {
                return new FileItem_1.FileItem(sourcePath);
            }
        });
    }
    execute(options) {
        return __awaiter(this, void 0, void 0, function* () {
            const { fileItem } = options;
            try {
                yield fileItem.remove(this.useTrash);
            }
            catch (e) {
                throw new Error(`Error deleting file '${fileItem.path}'.`);
            }
            return fileItem;
        });
    }
    get useTrash() {
        return config_1.getConfiguration('delete.useTrash');
    }
    get confirmDelete() {
        return config_1.getConfiguration('delete.confirm');
    }
}
exports.RemoveFileController = RemoveFileController;
//# sourceMappingURL=RemoveFileController.js.map