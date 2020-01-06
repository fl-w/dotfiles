"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const pubError_1 = require("../model/pubError");
const messaging_1 = require("./messaging");
const getValue = (f) => __awaiter(this, void 0, void 0, function* () {
    let value;
    let tryAgain = true;
    while (tryAgain) {
        try {
            value = yield f();
            tryAgain = false;
        }
        catch (error) {
            if (error instanceof pubError_1.PubApiNotRespondingError) {
                tryAgain = yield messaging_1.showRetryableError(error);
            }
            else {
                messaging_1.showCriticalError(error);
                tryAgain = false;
            }
        }
    }
    return value;
});
exports.getValue = getValue;
//# sourceMappingURL=getValue.js.map