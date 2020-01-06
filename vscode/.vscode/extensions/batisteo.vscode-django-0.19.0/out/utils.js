"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const path = require("path");
const fs = require("fs");
const toml = require("toml");
const folder = path.resolve(__dirname, '../completions/snippets/');
function readSnippets(name) {
    return toml.parse(fs.readFileSync(path.resolve(folder, name), 'utf-8')).snippets;
}
exports.readSnippets = readSnippets;
//# sourceMappingURL=utils.js.map