"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const typescript_parser_1 = require("typescript-parser");
const utility_functions_1 = require("../../utilities/utility-functions");
const import_group_order_1 = require("./import-group-order");
class RemainImportGroup {
    constructor(order = import_group_order_1.ImportGroupOrder.Asc) {
        this.order = order;
        this.imports = [];
    }
    get sortedImports() {
        const sorted = this.imports.sort((i1, i2) => utility_functions_1.importSort(i1, i2, this.order));
        return [
            ...sorted.filter(i => i instanceof typescript_parser_1.StringImport),
            ...sorted.filter(i => !(i instanceof typescript_parser_1.StringImport)),
        ];
    }
    reset() {
        this.imports.length = 0;
    }
    processImport(tsImport) {
        this.imports.push(tsImport);
        return true;
    }
}
exports.RemainImportGroup = RemainImportGroup;
