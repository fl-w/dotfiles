# VSCode Eclipse-Like New Java Project

A VSCode extension for people who don't want to use maven or graddle project setups for the [Java Extension Pack extension](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack). It creates a project folder with a .classpath and .project file, along with the src and bin directories, similar to eclipse's new java project option.

## Features

* Sets up an eclipse-like project folder for java projects.
* Classpath is picked up by the [Java Extension Pack extension](https://marketplace.visualstudio.com/items?itemName=vscjava.vscode-java-pack) to enable inner-project class definition go-tos, docs, etc.

![Example](https://media.giphy.com/media/SKdBaI1lUxzMSwaEGl/giphy.gif)

## Usage

* Press `Cmd+Shift+P`(Mac) or `Ctrl+Shift+P`(Windows) and type `New Java Project` and hit enter.
* It will prompt for a project name and the Eclipse java build tool to use.

## Requirements

* None that I know of yet. It may need the eclipse build tools, but I have not been able to determine whether you do or not. (Pretty sure you don't)

## Known Issues

* None that I know of yet. Feel free to post an issue if you find something!

## Contributing
Feel free to fork and PR! This is my first typescript or javascript project, so if there are any faux pas, feel free to fix them.
