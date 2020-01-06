"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = require("tslib");
require("reflect-metadata");
const inversify_1 = require("inversify");
const typescript_parser_1 = require("typescript-parser");
const configuration_1 = require("./configuration");
const imports_1 = require("./imports");
const ioc_symbols_1 = require("./ioc-symbols");
const typescript_hero_1 = require("./typescript-hero");
const logger_1 = require("./utilities/logger");
const utility_functions_1 = require("./utilities/utility-functions");
const iocContainer = new inversify_1.Container();
iocContainer
    .bind(typescript_hero_1.TypescriptHero)
    .to(typescript_hero_1.TypescriptHero)
    .inSingletonScope();
iocContainer
    .bind(ioc_symbols_1.iocSymbols.activatables)
    .to(imports_1.ImportOrganizer)
    .inSingletonScope();
iocContainer
    .bind(ioc_symbols_1.iocSymbols.configuration)
    .to(configuration_1.Configuration)
    .inSingletonScope();
iocContainer
    .bind(ioc_symbols_1.iocSymbols.logger)
    .toDynamicValue((context) => {
    const extContext = context.container.get(ioc_symbols_1.iocSymbols.extensionContext);
    const config = context.container.get(ioc_symbols_1.iocSymbols.configuration);
    return logger_1.winstonLogger(config.verbosity(), extContext);
})
    .inSingletonScope();
iocContainer
    .bind(ioc_symbols_1.iocSymbols.importManager)
    .toProvider(c => (document) => tslib_1.__awaiter(this, void 0, void 0, function* () {
    const parser = c.container.get(ioc_symbols_1.iocSymbols.parser);
    const config = c.container.get(ioc_symbols_1.iocSymbols.configuration);
    const logger = c.container.get(ioc_symbols_1.iocSymbols.logger);
    const generatorFactory = c.container.get(ioc_symbols_1.iocSymbols.generatorFactory);
    const source = yield parser.parseSource(document.getText(), utility_functions_1.getScriptKind(document.fileName));
    return new imports_1.ImportManager(document, source, parser, config, logger, generatorFactory);
}));
iocContainer
    .bind(ioc_symbols_1.iocSymbols.parser)
    .toConstantValue(new typescript_parser_1.TypescriptParser());
iocContainer
    .bind(ioc_symbols_1.iocSymbols.generatorFactory)
    .toFactory((context) => {
    return (resource) => {
        const config = context.container.get(ioc_symbols_1.iocSymbols.configuration);
        return new typescript_parser_1.TypescriptCodeGenerator(config.typescriptGeneratorOptions(resource));
    };
});
exports.ioc = iocContainer;
