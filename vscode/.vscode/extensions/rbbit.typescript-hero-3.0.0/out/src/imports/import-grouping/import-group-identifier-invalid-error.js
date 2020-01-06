"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class ImportGroupIdentifierInvalidError extends Error {
    constructor(identifier) {
        super();
        this.message = `The identifier "${identifier}" does not match a keyword or a regex pattern (/ .. /).`;
    }
}
exports.ImportGroupIdentifierInvalidError = ImportGroupIdentifierInvalidError;
