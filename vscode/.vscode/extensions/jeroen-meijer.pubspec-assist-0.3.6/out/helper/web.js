"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const openurl = require("openurl");
function generateNewGitIssueUrl(content) {
    const url = `https://github.com/jeroen-meijer/pubspec-assist/issues/new?title=${content.title}&body=${content.body}`;
    return url;
}
exports.generateNewGitIssueUrl = generateNewGitIssueUrl;
function generateNewGitIssueContent(error) {
    let title = `Bug Report: ${error.message}`;
    let body = `
# Bug Report

## Description

<!-- If you want to give a brief description of the error, please do so here. -->

## Steps to Reproduce

<!-- Please tell me exactly how to reproduce the problem you are running into. -->

1. ...
2. ...
3. ...

## Exception Info

**Type:** \`${(typeof error).toString()}\`

**Name:** \`${error.name}\`

**Message:** \`${error.message}\`

**Stack:**

\`\`\`
${error.stack}
\`\`\`
`;
    return { title, body };
}
exports.generateNewGitIssueContent = generateNewGitIssueContent;
function openNewGitIssueUrl(error) {
    openurl.open(generateNewGitIssueUrl(generateNewGitIssueContent(error)));
}
exports.openNewGitIssueUrl = openNewGitIssueUrl;
//# sourceMappingURL=web.js.map