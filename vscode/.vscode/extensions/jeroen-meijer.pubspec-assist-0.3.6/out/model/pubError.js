"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
var SearchType;
(function (SearchType) {
    SearchType["PACKAGE"] = "PACKAGE";
    SearchType["QUERY"] = "QUERY";
    SearchType["PAGE"] = "PAGE";
    SearchType["OTHER"] = "OTHER";
})(SearchType || (SearchType = {}));
exports.QuerySearchInfo = (query) => {
    return {
        searchType: SearchType.QUERY,
        query,
        details: `Query: ${query}`
    };
};
exports.PageSearchInfo = (pageNumber) => {
    return {
        searchType: SearchType.PAGE,
        pageNumber,
        details: `Page number: ${pageNumber}`
    };
};
exports.PackageSearchInfo = (name) => {
    return {
        searchType: SearchType.PACKAGE,
        name,
        details: `Package name: ${name}`
    };
};
exports.OtherSearchInfo = (info) => {
    return {
        searchType: SearchType.OTHER,
        info,
        details: `Search info: ${info}`
    };
};
class PubError extends Error {
    constructor(message) {
        super(message);
        Object.setPrototypeOf(this, PubError.prototype);
    }
}
exports.PubError = PubError;
class PubApiNotRespondingError extends PubError {
    constructor() {
        super("The Pub API is not responding.\nPlease check your internet connection or try again.");
        Object.setPrototypeOf(this, PubApiNotRespondingError.prototype);
    }
}
exports.PubApiNotRespondingError = PubApiNotRespondingError;
class PubApiSearchError extends PubError {
    constructor(searchInfo) {
        let message = `
    No response from Pub API call.\n
    Search type: "${searchInfo.searchType.toString()}".\n
    Details: "${searchInfo.details}".`;
        super(message);
        Object.setPrototypeOf(this, PubApiSearchError.prototype);
    }
}
exports.PubApiSearchError = PubApiSearchError;
function getRestApiError(error) {
    if (["ENOTFOUND", "ETIMEDOUT"].some((errorDescription) => error.message.includes(errorDescription))) {
        return new PubApiNotRespondingError();
    }
    else {
        return new PubError(`Rest client error: ${error}`);
    }
}
exports.getRestApiError = getRestApiError;
//# sourceMappingURL=pubError.js.map