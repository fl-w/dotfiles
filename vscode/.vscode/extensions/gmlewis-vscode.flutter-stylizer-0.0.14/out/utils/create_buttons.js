"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode = require("vscode");
const buttons_1 = require("../constants/buttons");
const createButtons = (buttons) => {
    return buttons.map((command) => {
        const newBtn = vscode.window.createStatusBarItem(buttons_1.BTN_ALIGNMENT, buttons_1.BTN_PRIORITY);
        newBtn.command = command.command;
        newBtn.text = command.text;
        newBtn.tooltip = command.tooltip;
        return newBtn;
    });
};
exports.default = createButtons;
//# sourceMappingURL=create_buttons.js.map