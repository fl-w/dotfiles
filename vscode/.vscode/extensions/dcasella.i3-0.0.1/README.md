# i3wm Syntax

[![Visual Studio Marketplace](https://img.shields.io/vscode-marketplace/v/dcasella.i3.svg?style=flat-square)](https://marketplace.visualstudio.com/items?itemName=dcasella.i3)
[![Visual Studio Marketplace](https://img.shields.io/vscode-marketplace/d/dcasella.i3.svg?style=flat-square)](https://marketplace.visualstudio.com/items?itemName=dcasella.i3)
[![Visual Studio Marketplace](https://img.shields.io/vscode-marketplace/r/dcasella.i3.svg?style=flat-square)](https://marketplace.visualstudio.com/items?itemName=dcasella.i3)

Syntax definition for the i3wm configuration file for Sublime Text 3 and Visual Studio Code.  
Feel free to open GitHub Issues to report any problem with the syntax definition or submit suggestions.

## Installation

### Sublime Text 3

**Not available on the official Package Control channel** at the moment, use [i3wm-sublime](https://github.com/skk/i3wm-sublime) if you don't feel like adding the repository or manually installing this package.

**Add this Repository:**

<kbd>Ctrl</kbd>/<kbd>Command</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the Command Palette  
Select `Package Control: Add Repository`  
Insert the URL `https://github.com/dcasella/i3wm-syntax`  
Press <kbd>Enter</kbd>  
<kbd>Ctrl</kbd>/<kbd>Command</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd> to open the Command Palette  
Select `Package Control: Install Package`  
Search for `i3`  
Press <kbd>Enter</kbd>

**Manual:**

`git clone https://github.com/dcasella/i3wm-syntax.git <YourPackagesFolder>`

### Visual Studio Code

**Option 1:**

<kbd>Ctrl</kbd>/<kbd>Command</kbd>+<kbd>Shift</kbd>+<kbd>X</kbd> to open the Extensions tab  
Search for `i3`  
Click Install

**Option 2:**

<kbd>Ctrl</kbd>/<kbd>Command</kbd>+<kbd>P</kbd> to launch the command palette  
Write `ext install dcasella.i3`

## Syntax setup

### Sublime Text 3

Using [ApplySyntax](https://packagecontrol.io/packages/ApplySyntax).  
Add to your ApplySyntax User Settings:

```json
"syntaxes": [
    // ...
    {
        "syntax": "i3wm-syntax/syntaxes/i3",
        "rules": [
            { "file_path": ".*/.i3/config$" },
            { "file_path": ".*/i3/config$" }
        ]
    }
    // ...
]
```

### Visual Studio Code

Add to your User Settings:

```json
"files.associations": {
    // ...
    "**/.i3/config": "i3",
    "**/i3/config": "i3",
    // ...
},
```

## Screenshots

Example i3 config (Editor: Sublime Text 3) (Color scheme: [Monokai++](https://github.com/dcasella/monokai-plusplus))

![ST3 Screenshot](https://github.com/dcasella/i3wm-syntax/raw/master/screenshotst3.png)

## Credits

Forked from [i3wm-sublime](https://github.com/skk/i3wm-sublime) made by [skk](https://github.com/skk).

[i3 tiling window manager](http://i3wm.org).
