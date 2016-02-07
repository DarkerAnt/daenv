#!/bin/sh

source utils/install.sh

# [init env]
mkdir ~/src
# compilers and interpreters
pkg_install gcc gcc-c++ clang python3
link_file .gdbinit ~/

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
