"use strict";
var AbstractProvider = (function () {
    function AbstractProvider(global) {
        this._global = global;
        this._disposables = [];
    }
    AbstractProvider.prototype.dispose = function () {
        while (this._disposables.length) {
            this._disposables.pop().dispose();
        }
    };
    return AbstractProvider;
}());
Object.defineProperty(exports, "__esModule", { value: true });
exports.default = AbstractProvider;
//# sourceMappingURL=abstractProvider.js.map