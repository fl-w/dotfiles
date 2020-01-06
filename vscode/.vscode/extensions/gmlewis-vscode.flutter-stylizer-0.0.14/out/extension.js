'use strict';
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : new P(function (resolve) { resolve(result.value); }).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
Object.defineProperty(exports, "__esModule", { value: true });
const assert = require("assert");
const vscode = require("vscode");
const buttons_1 = require("./buttons/buttons");
const create_buttons_1 = require("./utils/create_buttons");
const update_statusbar_1 = require("./utils/update_statusbar");
const watch_editors_1 = require("./utils/watch_editors");
const commentRE = /^(.*?)\s*\/\/.*$/;
var EntityType;
(function (EntityType) {
    EntityType[EntityType["Unknown"] = 0] = "Unknown";
    EntityType[EntityType["BlankLine"] = 1] = "BlankLine";
    EntityType[EntityType["SingleLineComment"] = 2] = "SingleLineComment";
    EntityType[EntityType["MultiLineComment"] = 3] = "MultiLineComment";
    EntityType[EntityType["MainConstructor"] = 4] = "MainConstructor";
    EntityType[EntityType["NamedConstructor"] = 5] = "NamedConstructor";
    EntityType[EntityType["StaticVariable"] = 6] = "StaticVariable";
    EntityType[EntityType["InstanceVariable"] = 7] = "InstanceVariable";
    EntityType[EntityType["StaticPrivateVariable"] = 8] = "StaticPrivateVariable";
    EntityType[EntityType["PrivateInstanceVariable"] = 9] = "PrivateInstanceVariable";
    EntityType[EntityType["OverrideMethod"] = 10] = "OverrideMethod";
    EntityType[EntityType["OtherMethod"] = 11] = "OtherMethod";
    EntityType[EntityType["BuildMethod"] = 12] = "BuildMethod";
})(EntityType = exports.EntityType || (exports.EntityType = {}));
class DartLine {
    constructor(line, startOffset) {
        this.entityType = EntityType.Unknown;
        this.line = line;
        this.startOffset = startOffset;
        this.endOffset = startOffset + line.length - 1;
        let m = commentRE.exec(line);
        this.stripped = (m ? m[1] : this.line).trim();
        if (this.stripped.length === 0) {
            this.entityType = (line.indexOf('//') >= 0) ?
                EntityType.SingleLineComment : EntityType.BlankLine;
        }
    }
}
// DartEntity represents a single, independent feature of a DartClass.
class DartEntity {
    constructor() {
        this.entityType = EntityType.Unknown;
        this.lines = [];
        this.name = ""; // Used for sorting, but could be "".
    }
}
class DartClass {
    constructor(editor, className, classOffset, openCurlyOffset, closeCurlyOffset) {
        this.fullBuf = "";
        this.lines = []; // Line 0 is always the open curly brace.
        this.theConstructor = undefined;
        this.namedConstructors = [];
        this.staticVariables = [];
        this.instanceVariables = [];
        this.staticPrivateVariables = [];
        this.privateVariables = [];
        this.overrideMethods = [];
        this.otherMethods = [];
        this.buildMethod = undefined;
        this.editor = editor;
        this.className = className;
        this.classOffset = classOffset;
        this.openCurlyOffset = openCurlyOffset;
        this.closeCurlyOffset = closeCurlyOffset;
        const lessThanOffset = className.indexOf('<');
        if (lessThanOffset >= 0) { // Strip off <T>.
            this.className = className.substring(0, lessThanOffset);
        }
    }
    findFeatures(buf) {
        return __awaiter(this, void 0, void 0, function* () {
            this.fullBuf = buf;
            let lines = this.fullBuf.split('\n');
            let lineOffset = 0;
            lines.forEach((line) => {
                this.lines.push(new DartLine(line, lineOffset));
                lineOffset += line.length;
                // Change a blank line following a comment to a SingleLineComment in
                // order to keep it with the following entity.
                const numLines = this.lines.length;
                if (numLines > 1 &&
                    this.lines[numLines - 1].entityType === EntityType.BlankLine &&
                    isComment(this.lines[numLines - 2])) {
                    this.lines[numLines - 1].entityType = EntityType.SingleLineComment;
                }
            });
            this.identifyMultiLineComments();
            yield this.identifyMainConstructor();
            yield this.identifyNamedConstructors();
            yield this.identifyOverrideMethods();
            yield this.identifyOthers();
            // this.lines.forEach((line, index) => console.log('line #' + index.toString() + ' type=' + EntityType[line.entityType] + ': ' + line.line));
        });
    }
    genStripped(startLine) {
        let strippedLines = new Array();
        for (let i = startLine; i < this.lines.length; i++) {
            strippedLines.push(this.lines[i].stripped);
        }
        return strippedLines.join('\n');
    }
    identifyMultiLineComments() {
        let inComment = false;
        for (let i = 1; i < this.lines.length; i++) {
            let line = this.lines[i];
            if (line.entityType !== EntityType.Unknown) {
                continue;
            }
            if (inComment) {
                this.lines[i].entityType = EntityType.MultiLineComment;
                // Note: a multiline comment followed by code on the same
                // line is not supported.
                let endComment = line.stripped.indexOf('*/');
                if (endComment >= 0) {
                    inComment = false;
                    if (line.stripped.lastIndexOf('/*') > endComment + 1) {
                        inComment = true;
                    }
                }
                continue;
            }
            let startComment = line.stripped.indexOf('/*');
            if (startComment >= 0) {
                inComment = true;
                this.lines[i].entityType = EntityType.MultiLineComment;
                if (line.stripped.lastIndexOf('*/') > startComment + 1) {
                    inComment = false;
                }
            }
        }
    }
    identifyMainConstructor() {
        return __awaiter(this, void 0, void 0, function* () {
            const className = this.className + '(';
            for (let i = 1; i < this.lines.length; i++) {
                const line = this.lines[i];
                if (line.entityType !== EntityType.Unknown) {
                    continue;
                }
                const offset = line.stripped.indexOf(className);
                if (offset >= 0) {
                    if (offset > 0) {
                        const char = line.stripped.substring(offset - 1, offset);
                        if (char !== ' ' && char !== '\t') {
                            continue;
                        }
                    }
                    this.lines[i].entityType = EntityType.MainConstructor;
                    this.theConstructor = yield this.markMethod(i, className, EntityType.MainConstructor);
                    break;
                }
            }
        });
    }
    identifyNamedConstructors() {
        return __awaiter(this, void 0, void 0, function* () {
            const className = this.className + '.';
            for (let i = 1; i < this.lines.length; i++) {
                const line = this.lines[i];
                if (line.entityType !== EntityType.Unknown) {
                    continue;
                }
                const offset = line.stripped.indexOf(className);
                if (offset >= 0) {
                    if (offset > 0) {
                        const char = line.stripped.substring(offset - 1, offset);
                        if (char !== ' ' && char !== '\t') {
                            continue;
                        }
                    }
                    const openParenOffset = offset + line.stripped.substring(offset).indexOf('(');
                    const namedConstructor = line.stripped.substring(offset, openParenOffset + 1); // Include open parenthesis.
                    this.lines[i].entityType = EntityType.NamedConstructor;
                    let entity = yield this.markMethod(i, namedConstructor, EntityType.NamedConstructor);
                    this.namedConstructors.push(entity);
                }
            }
        });
    }
    identifyOverrideMethods() {
        return __awaiter(this, void 0, void 0, function* () {
            for (let i = 1; i < this.lines.length; i++) {
                const line = this.lines[i];
                if (line.entityType !== EntityType.Unknown) {
                    continue;
                }
                if (line.stripped.startsWith('@override') && i < this.lines.length - 1) {
                    const offset = this.lines[i + 1].stripped.indexOf('(');
                    if (offset >= 0) {
                        // Include open paren in name.
                        const ss = this.lines[i + 1].stripped.substring(0, offset + 1);
                        // Search for beginning of method name.
                        const nameOffset = ss.lastIndexOf(' ') + 1;
                        const name = ss.substring(nameOffset);
                        const entityType = (name === 'build(') ? EntityType.BuildMethod : EntityType.OverrideMethod;
                        this.lines[i].entityType = entityType;
                        let entity = yield this.markMethod(i + 1, name, entityType);
                        if (name === 'build(') {
                            this.buildMethod = entity;
                        }
                        else {
                            this.overrideMethods.push(entity);
                        }
                    }
                    else {
                        let entity = new DartEntity();
                        entity.entityType = EntityType.OverrideMethod;
                        let lineNum = i + 1;
                        // No open paren - could be a getter. See if it has a body.
                        if (this.lines[i + 1].stripped.indexOf('{') >= 0) {
                            const lineOffset = this.fullBuf.indexOf(this.lines[i + 1].line);
                            const inLineOffset = this.lines[i + 1].line.indexOf('{');
                            const relOpenCurlyOffset = lineOffset + inLineOffset;
                            assert.equal(this.fullBuf[relOpenCurlyOffset], '{', 'Expected open curly bracket at relative offset');
                            const absOpenCurlyOffset = this.openCurlyOffset + relOpenCurlyOffset;
                            const absCloseCurlyOffset = yield findMatchingBracket(this.editor, absOpenCurlyOffset);
                            const relCloseCurlyOffset = absCloseCurlyOffset - this.openCurlyOffset;
                            assert.equal(this.fullBuf[relCloseCurlyOffset], '}', 'Expected close curly bracket at relative offset');
                            let nextOffset = absCloseCurlyOffset - this.openCurlyOffset;
                            const bodyBuf = this.fullBuf.substring(lineOffset, nextOffset + 1);
                            const numLines = bodyBuf.split('\n').length;
                            for (let j = 0; j < numLines; j++) {
                                this.lines[lineNum + j].entityType = entity.entityType;
                                entity.lines.push(this.lines[lineNum + j]);
                            }
                        }
                        else {
                            // Find next ';', marking entityType forward.
                            for (let j = i + 1; j < this.lines.length; j++) {
                                this.lines[j].entityType = entity.entityType;
                                entity.lines.push(this.lines[j]);
                                const semicolonOffset = this.lines[j].stripped.indexOf(';');
                                if (semicolonOffset >= 0) {
                                    break;
                                }
                            }
                        }
                        // Preserve the comment lines leading up to the method.
                        for (lineNum--; lineNum > 0; lineNum--) {
                            if (isComment(this.lines[lineNum]) || this.lines[lineNum].stripped.startsWith('@')) {
                                this.lines[lineNum].entityType = entity.entityType;
                                entity.lines.unshift(this.lines[lineNum]);
                                continue;
                            }
                            break;
                        }
                        this.overrideMethods.push(entity);
                    }
                }
            }
        });
    }
    identifyOthers() {
        return __awaiter(this, void 0, void 0, function* () {
            for (let i = 1; i < this.lines.length; i++) {
                const line = this.lines[i];
                if (line.entityType !== EntityType.Unknown) {
                    continue;
                }
                let entity = yield this.scanMethod(i);
                if (entity.entityType === EntityType.Unknown) {
                    continue;
                }
                // Preserve the comment lines leading up to the entity.
                for (let lineNum = i - 1; lineNum > 0; lineNum--) {
                    if (isComment(this.lines[lineNum])) {
                        this.lines[lineNum].entityType = entity.entityType;
                        entity.lines.unshift(this.lines[lineNum]);
                        continue;
                    }
                    break;
                }
                switch (entity.entityType) {
                    case EntityType.OtherMethod:
                        this.otherMethods.push(entity);
                        break;
                    case EntityType.StaticVariable:
                        this.staticVariables.push(entity);
                        break;
                    case EntityType.StaticPrivateVariable:
                        this.staticPrivateVariables.push(entity);
                        break;
                    case EntityType.InstanceVariable:
                        this.instanceVariables.push(entity);
                        break;
                    case EntityType.PrivateInstanceVariable:
                        this.privateVariables.push(entity);
                        break;
                    default:
                        console.log('UNEXPECTED EntityType=', entity.entityType);
                        break;
                }
            }
        });
    }
    scanMethod(lineNum) {
        let entity = new DartEntity;
        let buf = this.genStripped(lineNum);
        let result = this.findSequence(buf);
        let sequence = result[0];
        let lineCount = result[1];
        let leadingText = result[2];
        const nameParts = leadingText.split(' ');
        let staticKeyword = false;
        let privateVar = false;
        if (nameParts.length > 0) {
            entity.name = nameParts[nameParts.length - 1];
            if (entity.name.startsWith('_')) {
                privateVar = true;
            }
            if (nameParts[0] === 'static') {
                staticKeyword = true;
            }
        }
        entity.entityType = EntityType.InstanceVariable;
        switch (true) {
            case privateVar && staticKeyword:
                entity.entityType = EntityType.StaticPrivateVariable;
                break;
            case staticKeyword:
                entity.entityType = EntityType.StaticVariable;
                break;
            case privateVar:
                entity.entityType = EntityType.PrivateInstanceVariable;
                break;
        }
        switch (sequence) {
            case '(){}':
                entity.entityType = EntityType.OtherMethod;
                break;
            case '();': // Abstract method.
                entity.entityType = EntityType.OtherMethod;
                break;
            case '=(){}':
                entity.entityType = EntityType.OtherMethod;
                break;
            default:
                if (sequence.indexOf('=>') >= 0) {
                    entity.entityType = EntityType.OtherMethod;
                }
                break;
        }
        // Force getters to be methods.
        if (leadingText.indexOf(' get ') >= 0) {
            entity.entityType = EntityType.OtherMethod;
        }
        for (let i = 0; i <= lineCount; i++) {
            this.lines[lineNum + i].entityType = entity.entityType;
            entity.lines.push(this.lines[lineNum + i]);
        }
        return entity;
    }
    findSequence(buf) {
        let result = new Array();
        let leadingText = "";
        let lineCount = 0;
        let openParenCount = 0;
        let openBraceCount = 0;
        let openCurlyCount = 0;
        for (let i = 0; i < buf.length; i++) {
            if (openParenCount > 0) {
                for (; i < buf.length; i++) {
                    switch (buf[i]) {
                        case '(':
                            openParenCount++;
                            break;
                        case ')':
                            openParenCount--;
                            break;
                        case '\n':
                            lineCount++;
                            break;
                    }
                    if (openParenCount === 0) {
                        result.push(buf[i]);
                        break;
                    }
                }
            }
            else if (openBraceCount > 0) {
                for (; i < buf.length; i++) {
                    switch (buf[i]) {
                        case '[':
                            openBraceCount++;
                            break;
                        case ']':
                            openBraceCount--;
                            break;
                        case '\n':
                            lineCount++;
                            break;
                    }
                    if (openBraceCount === 0) {
                        result.push(buf[i]);
                        return [result.join(''), lineCount, leadingText];
                    }
                }
            }
            else if (openCurlyCount > 0) {
                for (; i < buf.length; i++) {
                    switch (buf[i]) {
                        case '{':
                            openCurlyCount++;
                            break;
                        case '}':
                            openCurlyCount--;
                            break;
                        case '\n':
                            lineCount++;
                            break;
                    }
                    if (openCurlyCount === 0) {
                        result.push(buf[i]);
                        return [result.join(''), lineCount, leadingText];
                    }
                }
            }
            else {
                switch (buf[i]) {
                    case '(':
                        openParenCount++;
                        result.push(buf[i]);
                        if (leadingText === '') {
                            leadingText = buf.substring(0, i).trim();
                        }
                        break;
                    case '[':
                        openBraceCount++;
                        result.push(buf[i]);
                        if (leadingText === '') {
                            leadingText = buf.substring(0, i).trim();
                        }
                        break;
                    case '{':
                        openCurlyCount++;
                        result.push(buf[i]);
                        if (leadingText === '') {
                            leadingText = buf.substring(0, i).trim();
                        }
                        break;
                    case ';':
                        result.push(buf[i]);
                        if (leadingText === '') {
                            leadingText = buf.substring(0, i).trim();
                        }
                        return [result.join(''), lineCount, leadingText];
                    case '=':
                        if (i < buf.length - 1 && buf[i + 1] === '>') {
                            result.push('=>');
                        }
                        else {
                            result.push(buf[i]);
                        }
                        if (leadingText === '') {
                            leadingText = buf.substring(0, i).trim();
                        }
                        break;
                    case '\n':
                        lineCount++;
                        break;
                }
            }
        }
        return [result.join(''), lineCount, leadingText];
    }
    markMethod(lineNum, methodName, entityType) {
        return __awaiter(this, void 0, void 0, function* () {
            assert.equal(true, methodName.endsWith('('), 'markMethod: ' + methodName + ' must end with the open parenthesis.');
            let entity = new DartEntity;
            entity.entityType = entityType;
            entity.lines = [];
            entity.name = methodName;
            // Identify all lines within the main (or factory) constructor.
            const lineOffset = this.fullBuf.indexOf(this.lines[lineNum].line);
            const inLineOffset = this.lines[lineNum].line.indexOf(methodName);
            const relOpenParenOffset = lineOffset + inLineOffset + methodName.length - 1;
            assert.equal(this.fullBuf[relOpenParenOffset], '(', 'Expected open parenthesis at relative offset');
            const absOpenParenOffset = this.openCurlyOffset + relOpenParenOffset;
            const absCloseParenOffset = yield findMatchingBracket(this.editor, absOpenParenOffset);
            const relCloseParenOffset = absCloseParenOffset - this.openCurlyOffset;
            assert.equal(this.fullBuf[relCloseParenOffset], ')', 'Expected close parenthesis at relative offset');
            const curlyDeltaOffset = this.fullBuf.substring(relCloseParenOffset).indexOf('{');
            const semicolonOffset = this.fullBuf.substring(relCloseParenOffset).indexOf(';');
            let nextOffset = 0;
            if (curlyDeltaOffset < 0 || (curlyDeltaOffset >= 0 && semicolonOffset >= 0 && semicolonOffset < curlyDeltaOffset)) { // no body.
                nextOffset = relCloseParenOffset + semicolonOffset;
            }
            else {
                const absOpenCurlyOffset = absCloseParenOffset + curlyDeltaOffset;
                const absCloseCurlyOffset = yield findMatchingBracket(this.editor, absOpenCurlyOffset);
                nextOffset = absCloseCurlyOffset - this.openCurlyOffset;
            }
            const constructorBuf = this.fullBuf.substring(lineOffset, nextOffset + 1);
            const numLines = constructorBuf.split('\n').length;
            for (let i = 0; i < numLines; i++) {
                this.lines[lineNum + i].entityType = entityType;
                entity.lines.push(this.lines[lineNum + i]);
            }
            // Preserve the comment lines leading up to the method.
            for (lineNum--; lineNum > 0; lineNum--) {
                if (isComment(this.lines[lineNum]) || this.lines[lineNum].stripped.startsWith('@')) {
                    this.lines[lineNum].entityType = entityType;
                    entity.lines.unshift(this.lines[lineNum]);
                    continue;
                }
                break;
            }
            return entity;
        });
    }
}
const matchClassRE = /^(?:abstract\s+)?class\s+(\S+)\s*.*$/mg;
const findMatchingBracket = (editor, openParenOffset) => __awaiter(this, void 0, void 0, function* () {
    const position = editor.document.positionAt(openParenOffset);
    editor.selection = new vscode.Selection(position, position);
    yield vscode.commands.executeCommand('editor.action.jumpToBracket');
    const result = editor.document.offsetAt(editor.selection.active);
    return result;
});
const isComment = (line) => {
    return (line.entityType === EntityType.SingleLineComment ||
        line.entityType === EntityType.MultiLineComment);
};
const findOpenCurlyOffset = (buf, startOffset) => {
    const offset = buf.substring(startOffset).indexOf('{');
    return startOffset + offset;
};
// export for testing only.
exports.getClasses = (editor) => __awaiter(this, void 0, void 0, function* () {
    let document = editor.document;
    let classes = new Array();
    const buf = document.getText();
    while (true) {
        let mm = matchClassRE.exec(buf);
        if (!mm) {
            break;
        }
        let className = mm[1];
        let classOffset = buf.indexOf(mm[0]);
        let openCurlyOffset = findOpenCurlyOffset(buf, classOffset);
        if (openCurlyOffset <= classOffset) {
            console.log('expected "{" after "class" at offset ' + classOffset.toString());
            return classes;
        }
        let closeCurlyOffset = yield findMatchingBracket(editor, openCurlyOffset);
        if (closeCurlyOffset <= openCurlyOffset) {
            console.log('expected "}" after "{" at offset ' + openCurlyOffset.toString());
            return classes;
        }
        let dartClass = new DartClass(editor, className, classOffset, openCurlyOffset, closeCurlyOffset);
        yield dartClass.findFeatures(buf.substring(openCurlyOffset, closeCurlyOffset));
        classes.push(dartClass);
    }
    return classes;
});
function activate(context) {
    console.log('Congratulations, "Flutter Stylizer" is now active!');
    let disposable = vscode.commands.registerCommand('extension.flutterStylizer', () => __awaiter(this, void 0, void 0, function* () {
        const editor = vscode.window.activeTextEditor;
        if (!editor) {
            return; // No open text editor
        }
        let saveSelection = editor.selection;
        const classes = yield exports.getClasses(editor);
        console.log("Found " + classes.length.toString() + " classes.");
        // Rewrite the classes.
        for (let i = classes.length - 1; i >= 0; i--) {
            const dc = classes[i];
            const startPos = editor.document.positionAt(dc.openCurlyOffset);
            const endPos = editor.document.positionAt(dc.closeCurlyOffset);
            editor.selection = new vscode.Selection(startPos, endPos);
            let lines = new Array();
            lines.push(dc.lines[0].line); // Curly brace.
            let addEntity = (entity, separateEntities) => {
                if (entity === undefined) {
                    return;
                }
                entity.lines.forEach((line) => lines.push(line.line));
                if (separateEntities !== false || entity.lines.length > 1) {
                    if (lines.length > 0 && lines[lines.length - 1] !== '\n') {
                        lines.push('');
                    }
                }
            };
            let addEntities = (entities, separateEntities) => {
                if (entities.length === 0) {
                    return;
                }
                entities.forEach((e) => addEntity(e, separateEntities));
                if (separateEntities === false && lines.length > 0 && lines[lines.length - 1] !== '\n') {
                    lines.push('');
                }
            };
            let sortFunc = (a, b) => a.name.localeCompare(b.name);
            addEntity(dc.theConstructor);
            dc.namedConstructors.sort(sortFunc);
            addEntities(dc.namedConstructors);
            dc.staticVariables.sort(sortFunc);
            addEntities(dc.staticVariables, false);
            dc.instanceVariables.sort(sortFunc);
            addEntities(dc.instanceVariables, false);
            dc.staticPrivateVariables.sort(sortFunc);
            addEntities(dc.staticPrivateVariables, false);
            dc.privateVariables.sort(sortFunc);
            addEntities(dc.privateVariables, false);
            // Strip a trailing blank line.
            if (lines.length > 2 && lines[lines.length - 1] === '' && lines[lines.length - 2] === '') {
                lines.pop();
            }
            dc.overrideMethods.sort(sortFunc);
            addEntities(dc.overrideMethods);
            addEntities(dc.otherMethods);
            // Preserve random single-line and multi-line comments.
            for (let i = 1; i < dc.lines.length; i++) {
                let foundComment = false;
                for (; i < dc.lines.length && isComment(dc.lines[i]); i++) {
                    lines.push(dc.lines[i].line);
                    foundComment = true;
                }
                if (foundComment) {
                    lines.push('');
                }
            }
            addEntity(dc.buildMethod);
            yield editor.edit((editBuilder) => {
                editBuilder.replace(editor.selection, lines.join('\n'));
            });
        }
        editor.selection = saveSelection;
    }));
    context.subscriptions.push(disposable);
    if (vscode.extensions.getExtension('dart-code.dart-code') !== undefined) {
        const statusButtons = create_buttons_1.default(buttons_1.default);
        watch_editors_1.default(statusButtons);
        update_statusbar_1.default(vscode.window.activeTextEditor, statusButtons);
    }
}
exports.activate = activate;
function deactivate() {
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map