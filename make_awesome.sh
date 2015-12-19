#!/bin/sh
PKG_MGR=dnf

function pkg_install() {
    sudo $PKG_MGR install $@ -y
}

function link_file() {
    ln -s ${dirname%%/}$1 $2
}

# [init env]
mkdir ~/src

# [zsh]
pkg_install zsh
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
link_file .zshrc, ~/

# [emacs]
pkg_install emacs
# clang format
git clone https://github.com/llvm-mirror/clang.git ~/src/
link_file .emacs, ~/

# [i3]
pkg_install i3
link_file .i3 ~/
