'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const constants_1 = require("../constants");
const base_1 = require("./base");
class DjangoPythonCompletionItemProvider extends base_1.DjangoCompletionItemProvider {
    constructor() {
        super();
        this.selector = constants_1.PYTHON_SELECTOR;
        this.directory = 'python';
        this.files = ["imports.toml", "utils.toml"];
        this.loadSnippets();
    }
}
exports.DjangoPythonCompletionItemProvider = DjangoPythonCompletionItemProvider;
class DjangoAdminCompletionItemProvider extends base_1.DjangoCompletionItemProvider {
    constructor() {
        super();
        this.selector = Object.assign({ pattern: '**/admin{**/,}*.py' }, constants_1.PYTHON_SELECTOR);
        this.directory = "admin";
        this.files = ["classes.toml", "imports.toml", "options.toml"];
        this.loadSnippets();
    }
}
exports.DjangoAdminCompletionItemProvider = DjangoAdminCompletionItemProvider;
class DjangoFormCompletionItemProvider extends base_1.DjangoCompletionItemProvider {
    constructor() {
        super();
        this.selector = Object.assign({ pattern: '**/forms{**/,}*.py' }, constants_1.PYTHON_SELECTOR);
        this.directory = "forms";
        this.files = ["classes.toml", "imports.toml", "fields.toml", "fields-postgres.toml", "methods.toml"];
        this.loadSnippets();
    }
}
exports.DjangoFormCompletionItemProvider = DjangoFormCompletionItemProvider;
class DjangoManagerCompletionItemProvider extends base_1.DjangoCompletionItemProvider {
    constructor() {
        super();
        this.selector = Object.assign({ pattern: '**/{models,managers,querysets}{**/,}*.py' }, constants_1.PYTHON_SELECTOR);
        this.directory = "models";
        this.files = ["managers.toml"];
        this.loadSnippets();
    }
}
exports.DjangoManagerCompletionItemProvider = DjangoManagerCompletionItemProvider;
class DjangoMigrationCompletionItemProvider extends base_1.DjangoCompletionItemProvider {
    constructor() {
        super();
        this.selector = Object.assign({ pattern: '**/migrations/**/*.py' }, constants_1.PYTHON_SELECTOR);
        this.directory = "models";
        this.files = ["migrations.toml"];
        this.loadSnippets();
    }
}
exports.DjangoMigrationCompletionItemProvider = DjangoMigrationCompletionItemProvider;
class DjangoModelCompletionItemProvider extends base_1.DjangoCompletionItemProvider {
    constructor() {
        super();
        this.selector = Object.assign({ pattern: '**/{models,migrations}{**/,}*.py' }, constants_1.PYTHON_SELECTOR);
        this.directory = "models";
        this.files = ["classes.toml", "imports.toml", "fields.toml", "fields-postgres.toml", "methods.toml"];
        this.loadSnippets();
    }
}
exports.DjangoModelCompletionItemProvider = DjangoModelCompletionItemProvider;
class DjangoViewCompletionItemProvider extends base_1.DjangoCompletionItemProvider {
    constructor() {
        super();
        this.selector = Object.assign({ pattern: '**/views{**/,}*.py' }, constants_1.PYTHON_SELECTOR);
        this.directory = "views";
        this.files = ["classes.toml", "imports.toml", "methods.toml"];
        this.loadSnippets();
    }
}
exports.DjangoViewCompletionItemProvider = DjangoViewCompletionItemProvider;
class DjangoTemplatetagsCompletionItemProvider extends base_1.DjangoCompletionItemProvider {
    constructor() {
        super();
        this.selector = Object.assign({ pattern: '**/templatetags/**/*.py' }, constants_1.PYTHON_SELECTOR);
        this.directory = "templatetags";
        this.files = ["imports.toml", "methods.toml"];
        this.loadSnippets();
    }
}
exports.DjangoTemplatetagsCompletionItemProvider = DjangoTemplatetagsCompletionItemProvider;
class DjangoUrlCompletionItemProvider extends base_1.DjangoCompletionItemProvider {
    constructor() {
        super();
        this.selector = Object.assign({ pattern: '**/urls{**/,}*.py' }, constants_1.PYTHON_SELECTOR);
        this.directory = "urls";
        this.files = ["imports.toml", "methods.toml", "regexes.toml"];
        this.loadSnippets();
    }
}
exports.DjangoUrlCompletionItemProvider = DjangoUrlCompletionItemProvider;
//# sourceMappingURL=completionItemProvider.js.map