"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = require("tslib");
const typescript_parser_1 = require("typescript-parser");
const vscode_1 = require("vscode");
const utility_functions_1 = require("../utilities/utility-functions");
function sameSpecifiers(specs1, specs2) {
    for (const spec of specs1) {
        const spec2 = specs2[specs1.indexOf(spec)];
        if (!spec2 ||
            spec.specifier !== spec2.specifier ||
            spec.alias !== spec2.alias) {
            return false;
        }
    }
    return true;
}
function importRange(document, start, end) {
    return start !== undefined && end !== undefined
        ? new vscode_1.Range(document.lineAt(document.positionAt(start).line).rangeIncludingLineBreak.start, document.lineAt(document.positionAt(end).line).rangeIncludingLineBreak.end)
        : new vscode_1.Range(new vscode_1.Position(0, 0), new vscode_1.Position(0, 0));
}
exports.importRange = importRange;
class ImportManager {
    constructor(document, _parsedDocument, parser, config, logger, generatorFactory) {
        this.document = document;
        this._parsedDocument = _parsedDocument;
        this.parser = parser;
        this.config = config;
        this.logger = logger;
        this.generatorFactory = generatorFactory;
        this.importGroups = [];
        this.imports = [];
        this.organize = false;
        this.logger.debug(`[ImportManager] Create import manager`, {
            file: document.fileName,
        });
        this.reset();
    }
    get rootPath() {
        const rootFolder = vscode_1.workspace.getWorkspaceFolder(this.document.uri);
        return rootFolder ? rootFolder.uri.fsPath : undefined;
    }
    get generator() {
        return this.generatorFactory(this.document.uri);
    }
    get parsedDocument() {
        return this._parsedDocument;
    }
    reset() {
        this.imports = this._parsedDocument.imports.map(o => o.clone());
        this.importGroups = this.config.imports.grouping(this.document.uri);
        this.addImportsToGroups(this.imports);
    }
    organizeImports() {
        this.logger.debug('[ImportManager] Organize the imports', {
            file: this.document.fileName,
        });
        this.organize = true;
        let keep = [];
        if (this.config.imports.disableImportRemovalOnOrganize(this.document.uri)) {
            keep = this.imports;
        }
        else {
            for (const actImport of this.imports) {
                if (this.config.imports
                    .ignoredFromRemoval(this.document.uri)
                    .indexOf(actImport.libraryName) >= 0) {
                    keep.push(actImport);
                    continue;
                }
                if (actImport instanceof typescript_parser_1.NamespaceImport ||
                    actImport instanceof typescript_parser_1.ExternalModuleImport) {
                    if (this._parsedDocument.nonLocalUsages.indexOf(actImport.alias) > -1) {
                        keep.push(actImport);
                    }
                }
                else if (actImport instanceof typescript_parser_1.NamedImport) {
                    actImport.specifiers = actImport.specifiers
                        .filter(o => this._parsedDocument.nonLocalUsages.indexOf(o.alias || o.specifier) > -1)
                        .sort(utility_functions_1.specifierSort);
                    const defaultSpec = actImport.defaultAlias;
                    const libraryAlreadyImported = keep.find(d => d.libraryName === actImport.libraryName);
                    if (actImport.specifiers.length ||
                        (!!defaultSpec &&
                            [
                                ...this._parsedDocument.nonLocalUsages,
                                ...this._parsedDocument.usages,
                            ].indexOf(defaultSpec) >= 0)) {
                        if (libraryAlreadyImported) {
                            if (actImport.defaultAlias) {
                                libraryAlreadyImported.defaultAlias =
                                    actImport.defaultAlias;
                            }
                            libraryAlreadyImported.specifiers = [
                                ...libraryAlreadyImported.specifiers,
                                ...actImport.specifiers,
                            ];
                        }
                        else {
                            keep.push(actImport);
                        }
                    }
                }
                else if (actImport instanceof typescript_parser_1.StringImport) {
                    keep.push(actImport);
                }
            }
        }
        if (!this.config.imports.disableImportsSorting(this.document.uri)) {
            const sorter = this.config.imports.organizeSortsByFirstSpecifier(this.document.uri)
                ? utility_functions_1.importSortByFirstSpecifier
                : utility_functions_1.importSort;
            keep = [
                ...keep.filter(o => o instanceof typescript_parser_1.StringImport).sort(sorter),
                ...keep.filter(o => !(o instanceof typescript_parser_1.StringImport)).sort(sorter),
            ];
        }
        if (this.config.imports.removeTrailingIndex(this.document.uri)) {
            for (const imp of keep.filter(lib => lib.libraryName.endsWith('/index'))) {
                imp.libraryName = imp.libraryName.replace(/\/index$/, '');
            }
        }
        for (const group of this.importGroups) {
            group.reset();
        }
        this.imports = keep;
        this.addImportsToGroups(this.imports);
        return this;
    }
    addDeclarationImport(declarationInfo) {
        this.logger.debug('[ImportManager] Add declaration as import', {
            file: this.document.fileName,
            specifier: declarationInfo.declaration.name,
            library: declarationInfo.from,
        });
        const alreadyImported = this.imports.find(o => declarationInfo.from ===
            utility_functions_1.getAbsolutLibraryName(o.libraryName, this.document.fileName, this.rootPath) && o instanceof typescript_parser_1.NamedImport);
        if (alreadyImported) {
            if (declarationInfo.declaration instanceof typescript_parser_1.DefaultDeclaration) {
                delete alreadyImported.defaultAlias;
                alreadyImported.defaultAlias = declarationInfo.declaration.name;
            }
            else if (!alreadyImported.specifiers.some(o => o.specifier === declarationInfo.declaration.name)) {
                alreadyImported.specifiers.push(new typescript_parser_1.SymbolSpecifier(declarationInfo.declaration.name));
            }
        }
        else {
            let imp = new typescript_parser_1.NamedImport(utility_functions_1.getRelativeLibraryName(declarationInfo.from, this.document.fileName, this.rootPath));
            if (declarationInfo.declaration instanceof typescript_parser_1.ModuleDeclaration) {
                imp = new typescript_parser_1.NamespaceImport(declarationInfo.from, declarationInfo.declaration.name);
            }
            else if (declarationInfo.declaration instanceof typescript_parser_1.DefaultDeclaration) {
                imp.defaultAlias = declarationInfo.declaration.name;
            }
            else {
                imp.specifiers.push(new typescript_parser_1.SymbolSpecifier(declarationInfo.declaration.name));
            }
            this.imports.push(imp);
            this.addImportsToGroups([imp]);
        }
        return this;
    }
    commit() {
        return tslib_1.__awaiter(this, void 0, void 0, function* () {
            const edits = this.calculateTextEdits();
            const workspaceEdit = new vscode_1.WorkspaceEdit();
            workspaceEdit.set(this.document.uri, edits);
            this.logger.debug('[ImportManager] Commit the file', {
                file: this.document.fileName,
            });
            const result = yield vscode_1.workspace.applyEdit(workspaceEdit);
            if (result) {
                delete this.organize;
                this._parsedDocument = yield this.parser.parseSource(this.document.getText(), utility_functions_1.getScriptKind(this.document.fileName));
                this.imports = this._parsedDocument.imports.map(o => o.clone());
                for (const group of this.importGroups) {
                    group.reset();
                }
                this.addImportsToGroups(this.imports);
            }
            return result;
        });
    }
    calculateTextEdits() {
        const edits = [];
        if (this.organize) {
            for (const imp of this._parsedDocument.imports) {
                edits.push(vscode_1.TextEdit.delete(importRange(this.document, imp.start, imp.end)));
                if (imp.end !== undefined) {
                    const nextLine = this.document.lineAt(this.document.positionAt(imp.end).line + 1);
                    if (nextLine.text === '') {
                        edits.push(vscode_1.TextEdit.delete(nextLine.rangeIncludingLineBreak));
                    }
                }
            }
            const imports = this.importGroups
                .map(group => this.generator.generate(group))
                .filter(Boolean)
                .join('\n');
            if (!!imports) {
                edits.push(vscode_1.TextEdit.insert(utility_functions_1.getImportInsertPosition(vscode_1.window.activeTextEditor), `${imports}\n`));
            }
        }
        else {
            for (const imp of this._parsedDocument.imports) {
                if (!this.imports.some(o => o.libraryName === imp.libraryName)) {
                    edits.push(vscode_1.TextEdit.delete(importRange(this.document, imp.start, imp.end)));
                }
            }
            const actualDocumentsNamed = this._parsedDocument.imports.filter(o => o instanceof typescript_parser_1.NamedImport);
            for (const imp of this.imports) {
                if (imp instanceof typescript_parser_1.NamedImport &&
                    actualDocumentsNamed.some(o => o.libraryName === imp.libraryName &&
                        o.defaultAlias === imp.defaultAlias &&
                        o.specifiers.length === imp.specifiers.length &&
                        sameSpecifiers(o.specifiers, imp.specifiers))) {
                    continue;
                }
                if (imp.isNew) {
                    edits.push(vscode_1.TextEdit.insert(utility_functions_1.getImportInsertPosition(vscode_1.window.activeTextEditor), this.generator.generate(imp) + '\n'));
                }
                else {
                    edits.push(vscode_1.TextEdit.replace(new vscode_1.Range(this.document.positionAt(imp.start), this.document.positionAt(imp.end)), this.generator.generate(imp)));
                }
            }
        }
        return edits;
    }
    addImportsToGroups(imports) {
        const importGroupsWithPrecedence = utility_functions_1.importGroupSortForPrecedence(this.importGroups);
        for (const tsImport of imports) {
            for (const group of importGroupsWithPrecedence) {
                if (group.processImport(tsImport)) {
                    break;
                }
            }
        }
    }
}
exports.ImportManager = ImportManager;
