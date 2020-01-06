"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class PubPackageSearch {
    constructor(nextUrl, packages, json) {
        this.nextUrl = nextUrl;
        this.packages = packages;
        this.json = json;
    }
    static fromJSON(json) {
        return new PubPackageSearch(json["next_url"], json["packages"].map(element => element.package), json);
    }
}
exports.PubPackageSearch = PubPackageSearch;
//# sourceMappingURL=pubSearch.js.map