"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const import_group_identifier_invalid_error_1 = require("./import-group-identifier-invalid-error");
const import_group_keyword_1 = require("./import-group-keyword");
const import_group_order_1 = require("./import-group-order");
const keyword_import_group_1 = require("./keyword-import-group");
const regex_import_group_1 = require("./regex-import-group");
const remain_import_group_1 = require("./remain-import-group");
const REGEX_REGEX_GROUP = /^\/.+\/$/;
class ImportGroupSettingParser {
    static get default() {
        return [
            new keyword_import_group_1.KeywordImportGroup(import_group_keyword_1.ImportGroupKeyword.Plains),
            new keyword_import_group_1.KeywordImportGroup(import_group_keyword_1.ImportGroupKeyword.Modules),
            new keyword_import_group_1.KeywordImportGroup(import_group_keyword_1.ImportGroupKeyword.Workspace),
            new remain_import_group_1.RemainImportGroup(),
        ];
    }
    static parseSetting(setting) {
        let identifier;
        let order = import_group_order_1.ImportGroupOrder.Asc;
        if (typeof setting === 'string') {
            identifier = setting;
        }
        else {
            identifier = setting.identifier;
            order = setting.order;
        }
        if (REGEX_REGEX_GROUP.test(identifier)) {
            return new regex_import_group_1.RegexImportGroup(identifier, order);
        }
        if (identifier === import_group_keyword_1.ImportGroupKeyword.Remaining) {
            return new remain_import_group_1.RemainImportGroup(order);
        }
        if (import_group_keyword_1.ImportGroupKeyword[identifier] !== undefined) {
            return new keyword_import_group_1.KeywordImportGroup(import_group_keyword_1.ImportGroupKeyword[identifier], order);
        }
        throw new import_group_identifier_invalid_error_1.ImportGroupIdentifierInvalidError(identifier);
    }
}
exports.ImportGroupSettingParser = ImportGroupSettingParser;
