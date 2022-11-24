# Get the distro name and version.
# Use that info to obtain the correct package manager.
# stolen from Mikel https://unix.stackexchange.com/a/6348
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS_NAME=$NAME
    OS_VERSION=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS_NAME=$(lsb_release -si)
    OS_VERSION=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS_NAME=$DISTRIB_ID
    OS_VERSION=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS_NAME=Debian
    OS_VERSION=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS_NAME=$(uname -s)
    OS_VERSION=$(uname -r)
fi

if [[ "$OS_NAME" == "Fedora"* ]]; then
    OS_NAME="Fedora"
    PKG_MGR=dnf
elif [ "$OS_NAME" == "Ubuntu" ]; then
    PKG_MGR=apt-get
else
    # bail out
    echo "Failed to map distro info to package manager for OS_NAME=${OS_NAME}"
    exit 1
fi
