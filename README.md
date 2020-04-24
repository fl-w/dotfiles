# Dotfiles

A tidy `$HOME` is a tidy mind.


This repository consists of configuration for any tools I use within my [Arch Linux][arch] and [neovim][] development environment.
I use a *lot* of tools which culminate in a sort of Unix IDE,
I use [stow][] to link all of the required configuration into my home directory.

![screenshot](demo.png)
![screenshot2](demokde.png)

#### Screenshot 1
+ distro: arch
+ wm: i3-gaps
+ terminal: kitty
+ shell: fish
+ font: Fira Code Nerd Font Patch
+ bar: polybar
#### Screenshot 1
+ distro: arch
+ wm: kde-plasma
+ terminal: konsole
+ shell: fish
+ font: Source Code Pro
+ bar/dock: latte-dock

Polybar

My config is a modified Polybar-4 by adi1090x. - [GitHub]
## Quick start

`git clone https://github.com/folws/dotfiles ~/.dotfiles
bash -c ~/.dotfiles/install
`

## Overview
 * Introduction
 * Requirements
 * Recommended modules
 * Installation
 * Configuration
 * Troubleshooting
 * FAQ
 * Maintainers
```sh
# general
bin/       # global scripts
assets/    # wallpapers, sounds, screenshots, etc

# categories
base/      # provisions my system with the bare essentials
dev/       # relevant to software development & programming in general
editor/    # configuration for my text editors
misc/      # for various apps & tools
shell/     # shell utilities, including zsh + bash
```

## Unlicenced

This are my personal dots so do what you want.
Find the full [unlicense][] in the `UNLICENSE` file, but here's a snippet.

>This is free and unencumbered software released into the public domain.
>
>Anyone is free to copy, modify, publish, use, compile, sell, or distribute this software, either in source code form or as a compiled binary, for any purpose, commercial or non-commercial, and by any means.

Do what you want. Learn as much as you can. Unlicense more software.

[unlicense]: http://unlicense.org/
[arch]: https://www.archlinux.org/
[stow]: http://www.gnu.org/software/stow/
[yay]: https://github.com/Jguer/yay
[aur]: https://aur.archlinux.org/
[picom]: https://wiki.archlinux.org/index.php/Picom
[fish]: http://fishshell.com/
[neovim]: https://neovim.io/
