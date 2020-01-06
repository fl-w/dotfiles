import { AsyncDeclaration, CallableDeclaration, ExportableDeclaration } from './Declaration';
import { ParameterDeclaration } from './ParameterDeclaration';
import { VariableDeclaration } from './VariableDeclaration';
/**
 * Function declaration. Like the MethodDeclaration it contains the base info about the function
 * and additional stuff.
 *
 * @export
 * @class FunctionDeclaration
 * @implements {CallableDeclaration}
 * @implements {ExportableDeclaration}
 */
export declare class FunctionDeclaration implements AsyncDeclaration, CallableDeclaration, ExportableDeclaration {
    name: string;
    isExported: boolean;
    isAsync: boolean;
    type?: string | undefined;
    start?: number | undefined;
    end?: number | undefined;
    parameters: ParameterDeclaration[];
    variables: VariableDeclaration[];
    constructor(name: string, isExported: boolean, isAsync: boolean, type?: string | undefined, start?: number | undefined, end?: number | undefined);
}
