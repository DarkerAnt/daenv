#!/bin/bash
set -eo pipefail

# Make the directory of this script our local directory so that local paths resolve correctly.
pushd $(dirname $(realpath $0))

source utils/install.sh

# [init env]
mkdir -p ~/src
# compilers and interpreters
declare -A DT_MAP
DT_MAP[common]="clang cmake gcc llvm python3"
DT_MAP["Fedora"]="gcc-c++ clang-devel llvm-devel"
DT_MAP["Ubuntu"]="g++ clang-dev libclang-dev llvm-dev"
pkg_install ${DT_MAP[common]} ${DT_MAP[$OS_NAME]}
link_file .gdbinit ~/

# [tmux]
pkg_install tmux
link_file .tmux.conf ~/

# [text editors]
declare -A TE_MAP
TE_MAP[common]="emacs nano vim global"
TE_MAP["Fedora"]="the_silver_searcher global-ctags"
TE_MAP["Ubuntu"]="silversearcher-ag exuberant-ctags"
pkg_install ${TE_MAP[common]} ${TE_MAP[$OS_NAME]}
# clang format
git clone https://github.com/llvm-mirror/clang.git ~/src/clang
link_file .emacs ~/

# [i3]
pkg_install i3
link_file .i3 ~/

# [zsh]
declare -A SH_MAP
SH_MAP[common]="zsh"
SH_MAP["Fedora"]="util-linux-user"
SH_MAP["Ubuntu"]="util-linux"
pkg_install ${SH_MAP[common]} ${SH_MAP[$OS_NAME]}
chsh -s $(which zsh)

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
link_file .zshrc ~/

popd
