"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const path_1 = require("path");
const typescript_1 = require("typescript");
const typescript_parser_1 = require("typescript-parser");
const PathHelpers_1 = require("typescript-parser/utilities/PathHelpers");
const vscode_1 = require("vscode");
const import_grouping_1 = require("../imports/import-grouping");
function stringSort(strA, strB, order = 'asc') {
    let result = 0;
    if (strA < strB) {
        result = -1;
    }
    else if (strA > strB) {
        result = 1;
    }
    if (order === 'desc') {
        result *= -1;
    }
    return result;
}
exports.stringSort = stringSort;
function importGroupSortForPrecedence(importGroups) {
    const regexGroups = [];
    const otherGroups = [];
    for (const ig of importGroups) {
        (ig instanceof import_grouping_1.RegexImportGroup ? regexGroups : otherGroups).push(ig);
    }
    return regexGroups.concat(otherGroups);
}
exports.importGroupSortForPrecedence = importGroupSortForPrecedence;
function localeStringSort(strA, strB, order = 'asc') {
    let result = strA.localeCompare(strB);
    if (order === 'desc') {
        result *= -1;
    }
    return result;
}
function importSort(i1, i2, order = 'asc') {
    const strA = i1.libraryName.toLowerCase();
    const strB = i2.libraryName.toLowerCase();
    return stringSort(strA, strB, order);
}
exports.importSort = importSort;
function importSortByFirstSpecifier(i1, i2, order = 'asc') {
    const strA = getImportFirstSpecifier(i1);
    const strB = getImportFirstSpecifier(i2);
    return localeStringSort(strA, strB, order);
}
exports.importSortByFirstSpecifier = importSortByFirstSpecifier;
function getImportFirstSpecifier(imp) {
    if (imp instanceof typescript_parser_1.NamespaceImport || imp instanceof typescript_parser_1.ExternalModuleImport) {
        return imp.alias;
    }
    if (imp instanceof typescript_parser_1.StringImport) {
        return path_1.basename(imp.libraryName);
    }
    if (imp instanceof typescript_parser_1.NamedImport) {
        const namedSpecifiers = imp.specifiers
            .map(s => s.alias || s.specifier)
            .filter(Boolean);
        const marker = namedSpecifiers[0] || imp.defaultAlias;
        if (marker) {
            return marker;
        }
    }
    return path_1.basename(imp.libraryName);
}
function specifierSort(i1, i2) {
    return stringSort(i1.specifier, i2.specifier);
}
exports.specifierSort = specifierSort;
function getItemKind(declaration) {
    switch (true) {
        case declaration instanceof typescript_parser_1.ClassDeclaration:
            return vscode_1.CompletionItemKind.Class;
        case declaration instanceof typescript_parser_1.ConstructorDeclaration:
            return vscode_1.CompletionItemKind.Constructor;
        case declaration instanceof typescript_parser_1.DefaultDeclaration:
            return vscode_1.CompletionItemKind.File;
        case declaration instanceof typescript_parser_1.EnumDeclaration:
            return vscode_1.CompletionItemKind.Enum;
        case declaration instanceof typescript_parser_1.FunctionDeclaration:
            return vscode_1.CompletionItemKind.Function;
        case declaration instanceof typescript_parser_1.InterfaceDeclaration:
            return vscode_1.CompletionItemKind.Interface;
        case declaration instanceof typescript_parser_1.MethodDeclaration:
            return vscode_1.CompletionItemKind.Method;
        case declaration instanceof typescript_parser_1.ModuleDeclaration:
            return vscode_1.CompletionItemKind.Module;
        case declaration instanceof typescript_parser_1.ParameterDeclaration:
            return vscode_1.CompletionItemKind.Variable;
        case declaration instanceof typescript_parser_1.PropertyDeclaration:
            return vscode_1.CompletionItemKind.Property;
        case declaration instanceof typescript_parser_1.TypeAliasDeclaration:
            return vscode_1.CompletionItemKind.TypeParameter;
        case declaration instanceof typescript_parser_1.VariableDeclaration:
            const variable = declaration;
            return variable.isConst ?
                vscode_1.CompletionItemKind.Constant :
                vscode_1.CompletionItemKind.Variable;
        case declaration instanceof typescript_parser_1.GetterDeclaration:
        case declaration instanceof typescript_parser_1.SetterDeclaration:
            return vscode_1.CompletionItemKind.Method;
        default:
            return vscode_1.CompletionItemKind.Reference;
    }
}
exports.getItemKind = getItemKind;
function getScriptKind(filePath) {
    if (!filePath) {
        return typescript_1.ScriptKind.TS;
    }
    const parsed = path_1.parse(filePath);
    switch (parsed.ext) {
        case '.ts':
            return typescript_1.ScriptKind.TS;
        case '.tsx':
            return typescript_1.ScriptKind.TSX;
        case '.js':
            return typescript_1.ScriptKind.JS;
        case '.jsx':
            return typescript_1.ScriptKind.JSX;
        default:
            return typescript_1.ScriptKind.Unknown;
    }
}
exports.getScriptKind = getScriptKind;
function getDeclarationsFilteredByImports(declarationInfos, documentPath, imports, rootPath) {
    let declarations = declarationInfos;
    for (const tsImport of imports) {
        const importedLib = getAbsolutLibraryName(tsImport.libraryName, documentPath, rootPath);
        if (tsImport instanceof typescript_parser_1.NamedImport) {
            declarations = declarations.filter(d => d.from !== importedLib ||
                !tsImport.specifiers.some(s => s.specifier === d.declaration.name));
            if (tsImport.defaultAlias) {
                declarations = declarations.filter(d => !(tsImport.defaultAlias && d.declaration instanceof typescript_parser_1.DefaultDeclaration && d.from === importedLib));
            }
        }
        else if (tsImport instanceof typescript_parser_1.NamespaceImport || tsImport instanceof typescript_parser_1.ExternalModuleImport) {
            declarations = declarations.filter(o => o.from !== tsImport.libraryName);
        }
    }
    return declarations;
}
exports.getDeclarationsFilteredByImports = getDeclarationsFilteredByImports;
function getAbsolutLibraryName(library, actualFilePath, rootPath) {
    if (!library.startsWith('.') || !rootPath) {
        return library;
    }
    return '/' + PathHelpers_1.toPosix(path_1.relative(rootPath, path_1.normalize(path_1.join(path_1.parse(actualFilePath).dir, library)))).replace(/\/$/, '');
}
exports.getAbsolutLibraryName = getAbsolutLibraryName;
function getRelativeLibraryName(library, actualFilePath, rootPath) {
    if (!library.startsWith('/') || !rootPath) {
        return library;
    }
    const actualDir = path_1.parse('/' + path_1.relative(rootPath, actualFilePath)).dir;
    let relativePath = path_1.relative(actualDir, library);
    if (!relativePath.startsWith('.')) {
        relativePath = './' + relativePath;
    }
    else if (relativePath === '..') {
        relativePath += '/';
    }
    return PathHelpers_1.toPosix(relativePath);
}
exports.getRelativeLibraryName = getRelativeLibraryName;
const REGEX_IGNORED_LINE = /^\s*(?:\/\/|\/\*|\*\/|\*|#!|(['"])use strict\1)/;
function getImportInsertPosition(editor) {
    if (!editor) {
        return new vscode_1.Position(0, 0);
    }
    const lines = editor.document.getText().split('\n');
    const index = lines.findIndex(line => !REGEX_IGNORED_LINE.test(line));
    return new vscode_1.Position(Math.max(0, index), 0);
}
exports.getImportInsertPosition = getImportInsertPosition;
