"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = require("tslib");
const inversify_1 = require("inversify");
const typescript_parser_1 = require("typescript-parser");
const import_grouping_1 = require("./imports/import-grouping");
const ioc_symbols_1 = require("./ioc-symbols");
let TypescriptHero = class TypescriptHero {
    constructor(logger, activatables) {
        this.logger = logger;
        this.activatables = activatables;
    }
    setup() {
        this.logger.debug('[TypescriptHero] Setting up extension and activatables.');
        this.extendCodeGenerator();
        for (const activatable of this.activatables) {
            activatable.setup();
        }
    }
    start() {
        this.logger.debug('[TypescriptHero] Starting up extension and activatables.');
        for (const activatable of this.activatables) {
            activatable.start();
        }
    }
    stop() {
        this.logger.debug('[TypescriptHero] Stopping extension and activatables.');
        for (const activatable of this.activatables) {
            activatable.stop();
        }
    }
    dispose() {
        this.logger.debug('[TypescriptHero] Disposing extension and activatables.');
        for (const activatable of this.activatables) {
            activatable.dispose();
        }
    }
    extendCodeGenerator() {
        function simpleGenerator(generatable, options) {
            const gen = new typescript_parser_1.TypescriptCodeGenerator(options);
            const group = generatable;
            if (!group.imports.length) {
                return '';
            }
            return (group.sortedImports.map(imp => gen.generate(imp)).join('\n') + '\n');
        }
        typescript_parser_1.GENERATORS[import_grouping_1.KeywordImportGroup.name] = simpleGenerator;
        typescript_parser_1.GENERATORS[import_grouping_1.RegexImportGroup.name] = simpleGenerator;
        typescript_parser_1.GENERATORS[import_grouping_1.RemainImportGroup.name] = simpleGenerator;
    }
};
TypescriptHero = tslib_1.__decorate([
    inversify_1.injectable(),
    tslib_1.__param(0, inversify_1.inject(ioc_symbols_1.iocSymbols.logger)),
    tslib_1.__param(1, inversify_1.multiInject(ioc_symbols_1.iocSymbols.activatables)),
    tslib_1.__metadata("design:paramtypes", [Object, Array])
], TypescriptHero);
exports.TypescriptHero = TypescriptHero;
