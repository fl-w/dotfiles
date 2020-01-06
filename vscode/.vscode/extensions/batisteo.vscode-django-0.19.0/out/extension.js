'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const definitionProvider_1 = require("./providers/definitionProvider");
const completionItemProvider_1 = require("./completions/completionItemProvider");
function activate(context) {
    const definitions = new definitionProvider_1.TemplatePathProvider();
    context.subscriptions.push(vscode_1.languages.registerDefinitionProvider(definitions.selector, definitions));
    const djangoPythonSnippets = new completionItemProvider_1.DjangoPythonCompletionItemProvider();
    context.subscriptions.push(vscode_1.languages.registerCompletionItemProvider(djangoPythonSnippets.selector, djangoPythonSnippets));
    const djangoAdminSnippets = new completionItemProvider_1.DjangoAdminCompletionItemProvider();
    context.subscriptions.push(vscode_1.languages.registerCompletionItemProvider(djangoAdminSnippets.selector, djangoAdminSnippets));
    const djangoFormSnippets = new completionItemProvider_1.DjangoFormCompletionItemProvider();
    context.subscriptions.push(vscode_1.languages.registerCompletionItemProvider(djangoFormSnippets.selector, djangoFormSnippets));
    const djangoManagerSnippets = new completionItemProvider_1.DjangoManagerCompletionItemProvider();
    context.subscriptions.push(vscode_1.languages.registerCompletionItemProvider(djangoManagerSnippets.selector, djangoManagerSnippets));
    const djangoMigrationSnippets = new completionItemProvider_1.DjangoMigrationCompletionItemProvider();
    context.subscriptions.push(vscode_1.languages.registerCompletionItemProvider(djangoMigrationSnippets.selector, djangoMigrationSnippets));
    const djangoModelSnippets = new completionItemProvider_1.DjangoModelCompletionItemProvider();
    context.subscriptions.push(vscode_1.languages.registerCompletionItemProvider(djangoModelSnippets.selector, djangoModelSnippets));
    const djangoViewSnippets = new completionItemProvider_1.DjangoViewCompletionItemProvider();
    context.subscriptions.push(vscode_1.languages.registerCompletionItemProvider(djangoViewSnippets.selector, djangoViewSnippets));
    const djangoTemplatetagsSnippets = new completionItemProvider_1.DjangoTemplatetagsCompletionItemProvider();
    context.subscriptions.push(vscode_1.languages.registerCompletionItemProvider(djangoTemplatetagsSnippets.selector, djangoTemplatetagsSnippets));
    const djangoUrlSnippets = new completionItemProvider_1.DjangoUrlCompletionItemProvider();
    context.subscriptions.push(vscode_1.languages.registerCompletionItemProvider(djangoUrlSnippets.selector, djangoUrlSnippets));
}
exports.activate = activate;
//# sourceMappingURL=extension.js.map