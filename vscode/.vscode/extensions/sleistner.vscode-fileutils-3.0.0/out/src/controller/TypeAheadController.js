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
const TreeWalker_1 = require("../lib/TreeWalker");
function waitForIOEvents() {
    return __awaiter(this, void 0, void 0, function* () {
        return new Promise((resolve) => setImmediate(resolve));
    });
}
class TypeAheadController {
    constructor(cache, relativeToRoot) {
        this.cache = cache;
        this.relativeToRoot = relativeToRoot;
    }
    showDialog(sourcePath) {
        return __awaiter(this, void 0, void 0, function* () {
            const item = yield this.showQuickPick(this.buildQuickPickItems(sourcePath));
            if (!item) {
                throw new Error();
            }
            const selection = item.label;
            this.cache.put('last', selection);
            return path.join(sourcePath, selection);
        });
    }
    buildQuickPickItems(sourcePath) {
        return __awaiter(this, void 0, void 0, function* () {
            const directories = yield this.listDirectoriesAtSourcePath(sourcePath);
            return [
                ...this.buildQuickPickItemsHeader(),
                ...directories.map((directory) => this.buildQuickPickItem(directory))
            ];
        });
    }
    listDirectoriesAtSourcePath(sourcePath) {
        return __awaiter(this, void 0, void 0, function* () {
            yield waitForIOEvents();
            const treeWalker = new TreeWalker_1.TreeWalker();
            return treeWalker.directories(sourcePath);
        });
    }
    buildQuickPickItemsHeader() {
        const items = [
            this.buildQuickPickItem('/', `- ${this.relativeToRoot ? 'workspace root' : 'current file'}`)
        ];
        const lastEntry = this.cache.get('last');
        if (lastEntry) {
            items.push(this.buildQuickPickItem(lastEntry, '- last selection'));
        }
        return items;
    }
    buildQuickPickItem(label, description) {
        return { description, label };
    }
    showQuickPick(items) {
        return __awaiter(this, void 0, void 0, function* () {
            const hint = 'larger projects may take a moment to load';
            const placeHolder = `First, select an existing path to create relative to (${hint})`;
            return vscode_1.window.showQuickPick(items, { placeHolder });
        });
    }
}
exports.TypeAheadController = TypeAheadController;
//# sourceMappingURL=TypeAheadController.js.map