'use strict';
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
const constants_1 = require("../constants");
const utils_1 = require("../utils");
const settings = vscode_1.workspace.getConfiguration("django");
const exclusions = settings.snippets.exclude;
class DjangoCompletionItemProvider {
    constructor() {
        this.selector = constants_1.PYTHON_SELECTOR;
        this.directory = '';
        this.files = [];
        this.snippets = [];
    }
    loadSnippets() {
        if (!settings.snippets.use)
            return;
        if (exclusions.some(word => this.directory.includes(word)))
            return;
        this.snippets = Array.prototype.concat(...this.files
            .filter(file => !exclusions.some(word => file.includes(word)))
            .map(file => utils_1.readSnippets(`${this.directory}/${file}`)));
        if (!settings.i18n) {
            this.snippets = this.snippets.map(snippet => {
                snippet.body = snippet.body.replace(/_\("(\S*)"\)/g, '"$1"');
                return snippet;
            });
        }
    }
    buildSnippet(snippet) {
        let item = new vscode_1.CompletionItem(snippet.prefix, vscode_1.CompletionItemKind.Snippet);
        item.insertText = new vscode_1.SnippetString(snippet.body);
        item.detail = snippet.detail;
        item.documentation = new vscode_1.MarkdownString(snippet.description);
        return item;
    }
    provideCompletionItems(document, position, token, context) {
        return __awaiter(this, void 0, void 0, function* () {
            return this.snippets.map(this.buildSnippet);
        });
    }
}
exports.DjangoCompletionItemProvider = DjangoCompletionItemProvider;
//# sourceMappingURL=base.js.map