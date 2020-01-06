"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
/**
 * Parameter declaration. Is contained in a method or function delaration since a parameter can not be exported
 * by itself.
 *
 * @export
 * @class ParameterDeclaration
 * @implements {TypedDeclaration}
 */
class ParameterDeclaration {
    constructor(name, type, start, end) {
        this.name = name;
        this.type = type;
        this.start = start;
        this.end = end;
    }
}
exports.ParameterDeclaration = ParameterDeclaration;
class BoundParameterDeclaration extends ParameterDeclaration {
    constructor(startCharacter, endCharacter, start, end) {
        super('', '', start, end);
        this.startCharacter = startCharacter;
        this.endCharacter = endCharacter;
        this.parameters = [];
    }
    get name() {
        return this.parameters.length ?
            `${this.startCharacter} ${this.parameters.map(p => p.name).join(', ')} ${this.endCharacter}` :
            this.startCharacter + this.endCharacter;
    }
    set name(_) { }
    get type() {
        return this.typeReference ||
            this.parameters.length ?
            `{ ${this.parameters.map(p => p.type).join(', ')} }` :
            this.startCharacter + this.endCharacter;
    }
    set type(_) { }
}
exports.BoundParameterDeclaration = BoundParameterDeclaration;
class ObjectBoundParameterDeclaration extends BoundParameterDeclaration {
    constructor(start, end) {
        super('{', '}', start, end);
    }
}
exports.ObjectBoundParameterDeclaration = ObjectBoundParameterDeclaration;
class ArrayBoundParameterDeclaration extends BoundParameterDeclaration {
    constructor(start, end) {
        super('[', ']', start, end);
    }
}
exports.ArrayBoundParameterDeclaration = ArrayBoundParameterDeclaration;
