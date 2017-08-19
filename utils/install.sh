source ./config.sh

function pkg_install() {
    sudo $PKG_MGR install $@ -y
}

function link_file() {
    ln -si $(readlink -f $1) $2
}
