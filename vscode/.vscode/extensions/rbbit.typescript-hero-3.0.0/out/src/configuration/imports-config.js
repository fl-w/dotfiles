"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const import_grouping_1 = require("../imports/import-grouping");
const sectionKey = 'typescriptHero.imports';
class ImportsConfig {
    insertSpaceBeforeAndAfterImportBraces(resource) {
        return vscode_1.workspace
            .getConfiguration(sectionKey, resource)
            .get('insertSpaceBeforeAndAfterImportBraces', true);
    }
    insertSemicolons(resource) {
        return vscode_1.workspace
            .getConfiguration(sectionKey, resource)
            .get('insertSemicolons', true);
    }
    removeTrailingIndex(resource) {
        return vscode_1.workspace
            .getConfiguration(sectionKey, resource)
            .get('removeTrailingIndex', true);
    }
    stringQuoteStyle(resource) {
        return vscode_1.workspace
            .getConfiguration(sectionKey, resource)
            .get('stringQuoteStyle', `'`);
    }
    multiLineWrapThreshold(resource) {
        return vscode_1.workspace
            .getConfiguration(sectionKey, resource)
            .get('multiLineWrapThreshold', 125);
    }
    multiLineTrailingComma(resource) {
        return vscode_1.workspace
            .getConfiguration(sectionKey, resource)
            .get('multiLineTrailingComma', true);
    }
    disableImportRemovalOnOrganize(resource) {
        return vscode_1.workspace
            .getConfiguration(sectionKey, resource)
            .get('disableImportRemovalOnOrganize', false);
    }
    disableImportsSorting(resource) {
        return vscode_1.workspace
            .getConfiguration(sectionKey, resource)
            .get('disableImportsSorting', false);
    }
    organizeOnSave(resource) {
        return vscode_1.workspace
            .getConfiguration(sectionKey, resource)
            .get('organizeOnSave', false);
    }
    organizeSortsByFirstSpecifier(resource) {
        return vscode_1.workspace
            .getConfiguration(sectionKey, resource)
            .get('organizeSortsByFirstSpecifier', false);
    }
    ignoredFromRemoval(resource) {
        return vscode_1.workspace
            .getConfiguration(sectionKey, resource)
            .get('ignoredFromRemoval', ['react']);
    }
    grouping(resource) {
        const groups = vscode_1.workspace
            .getConfiguration(sectionKey, resource)
            .get('grouping');
        let importGroups = [];
        try {
            if (groups) {
                importGroups = groups.map(g => import_grouping_1.ImportGroupSettingParser.parseSetting(g));
            }
            else {
                importGroups = import_grouping_1.ImportGroupSettingParser.default;
            }
        }
        catch (e) {
            importGroups = import_grouping_1.ImportGroupSettingParser.default;
        }
        if (!importGroups.some(i => i instanceof import_grouping_1.RemainImportGroup)) {
            importGroups.push(new import_grouping_1.RemainImportGroup());
        }
        return importGroups;
    }
}
exports.ImportsConfig = ImportsConfig;
