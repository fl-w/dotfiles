'use strict';
Object.defineProperty(exports, "__esModule", { value: true });
const path_1 = require("path");
const vscode_1 = require("vscode");
const constants_1 = require("../constants");
let regex = (regexes) => new RegExp(regexes.map(re => re.source).join(''));
const quote = /(?:\'|\")/;
const path_re = /([\w/\-]+\.[\w]+)/;
const rel_path_re = /((?:(?:\.\/|(?:\.\.\/)+))[\w/\-]+\.[\w]+)/;
const PATH_RE = regex([quote, path_re, quote]);
const RELATIVE_PATH_RE = regex([quote, rel_path_re, quote]);
const BEGIN_OF_FILE = new vscode_1.Position(0, 0);
let cache = {};
class TemplatePathProvider {
    constructor() {
        this.selector = [constants_1.DJANGO_HTML_SELECTOR, constants_1.PYTHON_SELECTOR];
    }
    static getTemplate(document, position, token) {
        let path;
        let search;
        let line = document.lineAt(position.line).text;
        let match = line.match(PATH_RE);
        let relative_match = line.match(RELATIVE_PATH_RE);
        if (relative_match) {
            path = relative_match[1];
            search = vscode_1.workspace.asRelativePath(path_1.resolve(path_1.dirname(document.uri.path), path));
        }
        else if (match) {
            path = match[1];
            search = `**/templates/${path}`;
        }
        else {
            return Promise.resolve(null);
        }
        let pos = position.character;
        let cursorOverPath = pos > line.indexOf(path) && pos < line.indexOf(path) + path.length;
        let uri;
        if (search in cache) {
            uri = Promise.resolve(cache[search]);
        }
        else {
            uri = vscode_1.workspace.findFiles(search, '', 1, token).then(results => {
                let result = results.length ? results[0] : null;
                if (result)
                    cache[search] = result;
                return result;
            });
        }
        if (cursorOverPath) {
            return uri;
        }
        else {
            return Promise.resolve(null);
        }
    }
    provideDefinition(document, position, token) {
        return TemplatePathProvider.getTemplate(document, position, token).then(template => {
            if (!template)
                return null;
            return new vscode_1.Location(template, BEGIN_OF_FILE);
        });
    }
}
exports.TemplatePathProvider = TemplatePathProvider;
//# sourceMappingURL=definitionProvider.js.map