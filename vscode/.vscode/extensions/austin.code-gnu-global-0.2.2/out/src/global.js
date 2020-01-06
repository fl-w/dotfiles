"use strict";
var exec = require('child-process-promise').exec;
var iconv = require('iconv-lite');
var vscode = require('vscode');
function execute(command) {
    var configuration = vscode.workspace.getConfiguration('codegnuglobal');
    var encoding = configuration.get('encoding');
    var output = 'utf8';
    if (encoding != null && encoding != "") {
        output = 'binary';
    }
    return exec(command, {
        cwd: vscode.workspace.rootPath,
        encoding: output,
        maxBuffer: 10 * 1024 * 1024
    }).then(function (result) {
        if (encoding != null && encoding != "") {
            var decoded = iconv.decode(result.stdout, encoding);
            return decoded;
        }
        return result.stdout;
    }).fail(function (error) {
        console.error("Error: " + error);
    }).progress(function (childProcess) {
        console.log("Command: " + command + " running...");
    });
}
;
var Global = (function () {
    function Global(exec) {
        this.exec = exec;
    }
    Global.prototype.run = function (params) {
        return execute(this.exec + ' ' + params.join(' '));
    };
    Global.prototype.updateTags = function () {
        var configuration = vscode.workspace.getConfiguration('codegnuglobal');
        var shouldupdate = configuration.get('autoupdate', true);
        if (shouldupdate) {
            this.run(['-u']);
        }
    };
    Global.prototype.parseLine = function (content) {
        try {
            if (content == null || content == "")
                return null;
            var values = content.split(/ +/);
            var tag = values.shift();
            var line = parseInt(values.shift()) - 1;
            var path = values.shift().replace("%20", " ");
            var info = values.join(' ');
            return { "tag": tag, "line": line, "path": path, "info": info, "kind": this.parseKind(info) };
        }
        catch (ex) {
            console.error("Error: " + ex);
        }
        return null;
    };
    Global.prototype.parseKind = function (info) {
        var kind = vscode.SymbolKind.Variable;
        if (info.startsWith('class ')) {
            kind = vscode.SymbolKind.Class;
        }
        else if (info.startsWith('struct ')) {
            kind = vscode.SymbolKind.Class;
        }
        else if (info.startsWith('enum ')) {
            kind = vscode.SymbolKind.Enum;
        }
        else if (info.indexOf('(') != -1) {
            kind = vscode.SymbolKind.Function;
        }
        return kind;
    };
    return Global;
}());
exports.Global = Global;
//# sourceMappingURL=global.js.map