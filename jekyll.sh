#!/bin/sh

source config.sh
source utils/install.sh

# [web server]
source nginx.sh

# [jekyll deps]
pkg_install ruby rubygems

# [jekyll]
sudo gem install jekyll
