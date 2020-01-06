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
const vscode = require("vscode");
const path = require("path");
const fs = require("fs");
const xmlbuilder = require("xmlbuilder");
function promptForFolder() {
    return __awaiter(this, void 0, void 0, function* () {
        /*
         * promptForFolder
         * Prompts the user for the folder to create the project in and returns it.
         */
        try {
            return yield vscode.window.showInputBox({
                prompt: 'Folder name to create project folder in. Must be in your workspace.',
                placeHolder: 'Folder name.'
            });
        }
        catch (e) {
            return;
        }
    });
}
exports.promptForFolder = promptForFolder;
function promptForProjectName() {
    return __awaiter(this, void 0, void 0, function* () {
        /*
         * promptForProjectName
         * Prompts the user for the project name.
         */
        try {
            return yield vscode.window.showInputBox({
                prompt: 'Project name. Will be used as the folder name of your java project.',
                placeHolder: 'Project name.'
            });
        }
        catch (e) {
            return;
        }
    });
}
exports.promptForProjectName = promptForProjectName;
function promptForJavaVersion() {
    return __awaiter(this, void 0, void 0, function* () {
        /*
         * promptForJavaVersion
         * Prompts the user for the java version to use for the eclipse build.
         */
        try {
            return yield vscode.window.showInputBox({
                prompt: 'The Eclipse java version to build with. (Ex: JavaSE-8, JavaSE-10)',
                value: 'JavaSE-10'
            });
        }
        catch (e) {
            return;
        }
    });
}
exports.promptForJavaVersion = promptForJavaVersion;
function findFolderInWorkspace(baseName, folders) {
    /*
     * findFolderInWorkspace
     * Given a baseName and the folders to look through, return the fsPath if the baseName is found.
     * Else, return undefined.
     */
    for (var i = 0; i < folders.length; i++) {
        const element = folders[i];
        if (path.basename(element.uri.fsPath) === baseName) {
            return element.uri.fsPath;
        }
    }
    return undefined;
}
exports.findFolderInWorkspace = findFolderInWorkspace;
function getWorkspaceRoot(folders, multi, baseName) {
    return __awaiter(this, void 0, void 0, function* () {
        /*
         * getWorkspaceRoot
         * Figures out which folder to make the project in.
         */
        if (multi) { // Multiple folders in workspace
            if (baseName === "" || baseName === undefined) { // Nothing entered
                return undefined;
            }
            const folderPath = findFolderInWorkspace(baseName, folders);
            if (folderPath) {
                return folderPath;
            }
            else {
                // Did not find baseName in workspace folders
                yield vscode.window.showErrorMessage('Could not find the folder ' + baseName + ' in your workspace. ' +
                    'Please try again.');
                return undefined;
            }
        }
        else { // Single folder in workspace, return that folder
            return folders[0].uri.fsPath;
        }
    });
}
exports.getWorkspaceRoot = getWorkspaceRoot;
function createProjectFile(projectName) {
    /*
     * createProjectFile
     * Create the xml for the .project file and return the result as a string.
     */
    const projectObj = {
        'projectDescription': {
            'name': projectName,
            'comment': '',
            'projects': {},
            'buildSpec': {
                'buildCommand': {
                    'name': 'org.eclipse.jdt.core.javabuilder',
                    'arguments': {}
                }
            },
            'natures': {
                'nature': 'org.eclipse.jdt.core.javanature'
            }
        }
    };
    const xml = xmlbuilder.create(projectObj, { encoding: 'UTF-8' });
    return xml.end({ pretty: true });
}
exports.createProjectFile = createProjectFile;
function createClassPathFile(javaVersion) {
    /*
     * createClassPathFile
     * Create the xml for the .classpath file and return the result as a string.
     */
    const xml = xmlbuilder.create('classpath', { encoding: 'UTF-8' });
    var item = xml.ele('classpathentry');
    item.att('kind', 'con');
    item.att('path', 'org.eclipse.jdt.launching.JRE_CONTAINER/org.eclipse.jdt.internal.debug.ui.launcher.StandardVMType/' + javaVersion);
    var nestedItem = item.ele('attributes').ele('attribute');
    nestedItem.att('name', 'module');
    nestedItem.att('value', 'true');
    item = xml.ele('classpathentry');
    item.att('kind', 'src');
    item.att('path', 'src');
    item = xml.ele('classpathentry');
    item.att('kind', 'output');
    item.att('path', 'bin');
    return xml.end({ pretty: true });
}
exports.createClassPathFile = createClassPathFile;
function createProjectFolder(root, projectName, javaVersion) {
    return __awaiter(this, void 0, void 0, function* () {
        /*
         * createProjectFolder
         * Create the project folder, the src folder, the bin folder, and the .project
         * and .classpath files.
         */
        const fullPath = root + '/' + projectName;
        if (fs.existsSync(fullPath)) { // Make sure folder doesn't exist with same name
            yield vscode.window.showErrorMessage("A folder with the name " + projectName + " already exists.");
            return;
        }
        // Make all of the files and folders
        fs.mkdirSync(fullPath);
        const projectXMLString = createProjectFile(projectName);
        fs.writeFileSync(fullPath + '/.project', projectXMLString);
        const classpathXMLString = createClassPathFile(javaVersion);
        fs.writeFileSync(fullPath + '/.classpath', classpathXMLString);
        fs.mkdirSync(fullPath + '/src');
        fs.mkdirSync(fullPath + '/bin');
    });
}
exports.createProjectFolder = createProjectFolder;
function command(context) {
    return __awaiter(this, void 0, void 0, function* () {
        /*
         * NewJavaProject command
         * Runs the code.
         */
        // Figure out which folder to create in
        let folders = undefined;
        let multi = false;
        let root = undefined;
        if (vscode.workspace.workspaceFolders) {
            folders = vscode.workspace.workspaceFolders;
            multi = folders.length > 1;
            if (multi) {
                root = yield getWorkspaceRoot(folders, multi, yield promptForFolder());
            }
            else {
                root = yield getWorkspaceRoot(folders, multi);
            }
        }
        else if (vscode.workspace.rootPath) {
            root = vscode.workspace.rootPath;
        }
        else {
            yield vscode.window.showErrorMessage("You don't have any folders in your workspace. " +
                "Please add a folder to your workspace and try again.");
            return;
        }
        if (root === undefined) {
            return;
        }
        // Prompt for project name and create
        const projectName = yield promptForProjectName();
        if (projectName === undefined) {
            return;
        }
        else if (projectName === "" || projectName !== path.basename(projectName)) {
            yield vscode.window.showErrorMessage('Please enter a valid project name.');
            return;
        }
        // Prompt for Java Verison
        const javaVersion = yield promptForJavaVersion();
        // Validate javaVersion
        if (javaVersion === undefined || javaVersion === "") {
            yield vscode.window.showErrorMessage('Invalid Java Version.');
            return;
        }
        // Validate projectName and create projectFolder if true
        if (projectName) {
            createProjectFolder(root, projectName, javaVersion);
        }
        else {
            return;
        }
    });
}
exports.command = command;
// this method is called when the extension is activated
function activate(context) {
    let disposable = vscode.commands.registerCommand('extension.NewJavaProject', () => command(context));
    context.subscriptions.push(disposable);
}
exports.activate = activate;
// this method is called when your extension is deactivated
function deactivate() {
}
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map