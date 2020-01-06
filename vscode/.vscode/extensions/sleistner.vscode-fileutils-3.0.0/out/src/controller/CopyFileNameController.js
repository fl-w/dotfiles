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
const FileItem_1 = require("../FileItem");
const BaseFileController_1 = require("./BaseFileController");
class CopyFileNameController extends BaseFileController_1.BaseFileController {
    showDialog(options) {
        return __awaiter(this, void 0, void 0, function* () {
            const { uri = null } = options;
            const sourcePath = uri && uri.fsPath || (yield this.getSourcePath());
            if (!sourcePath) {
                throw new Error();
            }
            return new FileItem_1.FileItem(sourcePath);
        });
    }
    execute(options) {
        return __awaiter(this, void 0, void 0, function* () {
            yield vscode_1.env.clipboard.writeText(options.fileItem.name);
            return options.fileItem;
        });
    }
}
exports.CopyFileNameController = CopyFileNameController;
//# sourceMappingURL=CopyFileNameController.js.map