"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const updateStatusbar = (editor, buttons) => {
    let showButtons = false;
    if (editor !== undefined) {
        const { document: { languageId }, } = editor;
        if (languageId.indexOf('dart') === 0) {
            showButtons = true;
        }
    }
    buttons.forEach((btn) => {
        if (showButtons) {
            btn.show();
        }
        else {
            btn.hide();
        }
    });
};
exports.default = updateStatusbar;
//# sourceMappingURL=update_statusbar.js.map