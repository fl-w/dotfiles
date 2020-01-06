"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class Cache {
    constructor(storage, namespace) {
        this.storage = storage;
        this.namespace = namespace;
        this.cache = storage.get(this.namespace, {});
    }
    put(key, value) {
        this.cache[key] = value;
        this.storage.update(this.namespace, this.cache);
    }
    get(key, defaultValue) {
        return key in this.cache ? this.cache[key] : defaultValue;
    }
}
exports.Cache = Cache;
//# sourceMappingURL=Cache.js.map