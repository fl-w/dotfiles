"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const typescript_parser_1 = require("typescript-parser");
const utility_functions_1 = require("../../utilities/utility-functions");
const import_group_keyword_1 = require("./import-group-keyword");
const import_group_order_1 = require("./import-group-order");
class KeywordImportGroup {
    constructor(keyword, order = import_group_order_1.ImportGroupOrder.Asc) {
        this.keyword = keyword;
        this.order = order;
        this.imports = [];
    }
    get sortedImports() {
        return this.imports.sort((i1, i2) => utility_functions_1.importSort(i1, i2, this.order));
    }
    reset() {
        this.imports.length = 0;
    }
    processImport(tsImport) {
        switch (this.keyword) {
            case import_group_keyword_1.ImportGroupKeyword.Modules:
                return this.processModulesImport(tsImport);
            case import_group_keyword_1.ImportGroupKeyword.Plains:
                return this.processPlainsImport(tsImport);
            case import_group_keyword_1.ImportGroupKeyword.Workspace:
                return this.processWorkspaceImport(tsImport);
            default:
                return false;
        }
    }
    processModulesImport(tsImport) {
        if (tsImport instanceof typescript_parser_1.StringImport ||
            tsImport.libraryName.startsWith('.') ||
            tsImport.libraryName.startsWith('/')) {
            return false;
        }
        this.imports.push(tsImport);
        return true;
    }
    processPlainsImport(tsImport) {
        if (!(tsImport instanceof typescript_parser_1.StringImport)) {
            return false;
        }
        this.imports.push(tsImport);
        return true;
    }
    processWorkspaceImport(tsImport) {
        if (tsImport instanceof typescript_parser_1.StringImport ||
            (!tsImport.libraryName.startsWith('.') &&
                !tsImport.libraryName.startsWith('/'))) {
            return false;
        }
        this.imports.push(tsImport);
        return true;
    }
}
exports.KeywordImportGroup = KeywordImportGroup;
