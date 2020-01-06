"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const tslib_1 = require("tslib");
require("reflect-metadata");
const ioc_1 = require("./ioc");
const ioc_symbols_1 = require("./ioc-symbols");
const typescript_hero_1 = require("./typescript-hero");
let extension;
function activate(context) {
    return tslib_1.__awaiter(this, void 0, void 0, function* () {
        if (ioc_1.ioc.isBound(ioc_symbols_1.iocSymbols.extensionContext)) {
            ioc_1.ioc.unbind(ioc_symbols_1.iocSymbols.extensionContext);
        }
        ioc_1.ioc
            .bind(ioc_symbols_1.iocSymbols.extensionContext)
            .toConstantValue(context);
        extension = ioc_1.ioc.get(typescript_hero_1.TypescriptHero);
        extension.setup();
        extension.start();
    });
}
exports.activate = activate;
function deactivate() {
    extension.stop();
    extension.dispose();
}
exports.deactivate = deactivate;
