function pkg_install() {
    sudo $PKG_MGR install $@ -y
}

function link_file() {
    ln -s ${dirname%%/}$1 $2
}
