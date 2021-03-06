#!/bin/sh

source ./config.sh
source utils/install.sh

# [yum repo]
if [ "$OS_NAME" != "fedora" ]; then
  sudo sh -c "echo '[nginx]
  name=nginx repo
  baseurl=http://nginx.org/packages/$OS_NAME/$OS_VERSION/x86_64/
  gpgcheck=0
  enabled=1' > /etc/yum.repos.d/nginx.repo"
fi

# [nginx]
pkg_install nginx
