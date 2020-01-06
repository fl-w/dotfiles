"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
class PubPackage {
    constructor(name, latestVersion, flutterCompatible = false) {
        this.name = name;
        this.latestVersion = latestVersion;
        this.flutterCompatible = flutterCompatible;
    }
    static fromJSON(json) {
        return new PubPackage(json["name"], json["latest"]["version"], this.checkFlutterCompatibility(json));
    }
    static checkFlutterCompatibility(json) {
        const dependencies = json["latest"]["pubspec"]["dependencies"];
        if (dependencies && dependencies["flutter"]) {
            return true;
        }
        return false;
    }
    generateDependencyString() {
        return `${this.name}: ^${this.latestVersion}`;
    }
}
exports.PubPackage = PubPackage;
//# sourceMappingURL=pubPackage.js.map