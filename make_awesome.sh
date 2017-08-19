#!/bin/bash

# Make the directory of this script our local directory so that local paths resolve correctly.
pushd $(dirname $(readlink -f ${BASH_SOURCE[0]}))

source utils/install.sh

# [init env]
mkdir ~/src
# compilers and interpreters
pkg_install gcc gcc-c++ clang python3
link_file .gdbinit ~/

# [tmux]
link_file .tmux.conf ~/

# [text editors]
pkg_install emacs nano vim
pkg_install global global-ctags
# clang format
git clone https://github.com/llvm-mirror/clang.git ~/src/clang
link_file .emacs ~/

# [i3]
pkg_install i3
link_file .i3 ~/

# [zsh]
pkg_install zsh util-linux-user
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
link_file .zshrc ~/

popd
