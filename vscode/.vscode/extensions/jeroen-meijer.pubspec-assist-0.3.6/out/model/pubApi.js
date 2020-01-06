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
require("./pubPackage");
const vscode = require("vscode");
const rm = require("typed-rest-client/RestClient");
const Fuse = require("fuse-js-latest");
const escapeHtml_1 = require("../escapeHtml");
const pubPackage_1 = require("./pubPackage");
const pubPackageSearch_1 = require("./pubPackageSearch");
const pubPage_1 = require("./pubPage");
const pubError_1 = require("./pubError");
const pubError_2 = require("./pubError");
var ResponseStatus;
(function (ResponseStatus) {
    ResponseStatus["SUCCESS"] = "SUCCESS";
    ResponseStatus["FAILURE"] = "FAILURE";
})(ResponseStatus = exports.ResponseStatus || (exports.ResponseStatus = {}));
const SuccessResponse = (result) => {
    return {
        status: ResponseStatus.SUCCESS,
        result
    };
};
class PubAPI {
    constructor(baseUrl = "https://pub.dartlang.org/api/") {
        this.baseUrl = baseUrl;
        this.restClient = new rm.RestClient("Mozilla/5.0");
    }
    generateUrl(resource) {
        return this.baseUrl + resource;
    }
    getPage(id = 1) {
        return __awaiter(this, void 0, void 0, function* () {
            const response = yield this.getPageJson(id);
            let result = pubPage_1.PubPage.fromJSON(response);
            return SuccessResponse(result);
        });
    }
    getPageJson(id = 1) {
        return __awaiter(this, void 0, void 0, function* () {
            const res = yield this.restClient.get(this.generateUrl(`packages?page=${id}`));
            if (!res.result) {
                throw new pubError_2.PubApiSearchError(pubError_2.PageSearchInfo(id));
            }
            return res.result;
        });
    }
    searchPackage(query) {
        return __awaiter(this, void 0, void 0, function* () {
            const fullQuery = `search?q=${escapeHtml_1.escapeHtml(query)}`;
            try {
                const res = yield this.restClient.get(this.generateUrl(fullQuery));
                if (!res.result) {
                    throw new pubError_2.PubApiSearchError(pubError_2.PackageSearchInfo(query));
                }
                return SuccessResponse(pubPackageSearch_1.PubPackageSearch.fromJSON(res.result));
            }
            catch (e) {
                throw pubError_1.getRestApiError(e);
            }
        });
    }
    smartSearchPackage(query, singleReturnThreshold = 0.1) {
        return __awaiter(this, void 0, void 0, function* () {
            var fuseOptions = {
                shouldSort: true,
                includeScore: true,
                threshold: 0.5,
                location: 0,
                distance: 100,
                maxPatternLength: 32,
                minMatchCharLength: 1,
                keys: ["package"]
            };
            const response = yield this.searchPackage(query);
            if (!response.result) {
                throw new pubError_2.PubApiSearchError(pubError_2.PackageSearchInfo(query));
            }
            const searchResults = response.result;
            const fuse = new Fuse(searchResults.json.packages, fuseOptions);
            const rankedResult = fuse.search(query);
            const significantResults = rankedResult.filter(element => element.score <= singleReturnThreshold);
            if (significantResults.length === 1 &&
                vscode.workspace.getConfiguration().get("pubspec-assist.autoAddPackage")) {
                return {
                    status: ResponseStatus.SUCCESS,
                    result: new pubPackageSearch_1.PubPackageSearch([significantResults[0].item.package])
                };
            }
            else {
                return {
                    status: ResponseStatus.SUCCESS,
                    result: new pubPackageSearch_1.PubPackageSearch(rankedResult.map(element => element.item.package))
                };
            }
        });
    }
    getPackage(name) {
        return __awaiter(this, void 0, void 0, function* () {
            try {
                const res = yield this.restClient.get(this.generateUrl(`packages/${name}`));
                if (!res.result) {
                    throw new pubError_2.PubApiSearchError(pubError_2.PackageSearchInfo(name));
                }
                return SuccessResponse(pubPackage_1.PubPackage.fromJSON(res.result));
            }
            catch (e) {
                const error = e;
                console.log(`--getPackage-- name: ${error.name}, message: ${error.message}`);
                throw pubError_1.getRestApiError(e);
            }
        });
    }
}
exports.PubAPI = PubAPI;
//# sourceMappingURL=pubApi.js.map