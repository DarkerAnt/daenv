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
# compilers and interpreters
install_pkg gcc g++ clang python3

# [zsh]
pkg_install zsh
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
link_file .zshrc, ~/

# [tmux]
link_file .tmux.conf ~/

# [emacs]
pkg_install emacs
pkg_install global global-ctags
# clang format
git clone https://github.com/llvm-mirror/clang.git ~/src/
link_file .emacs, ~/

# [i3]
pkg_install i3
link_file .i3 ~/
