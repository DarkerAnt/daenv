#!/bin/sh

source utils/install.sh

# compilers and interpreters
pkg_install python3

# [zsh]
pkg_install zsh
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
link_file .zshrc, ~/

# [tmux]
link_file .tmux.conf ~/

# [emacs]
pkg_install emacs
link_file .emacs, ~/
