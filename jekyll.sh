#!/bin/sh

source ./config.sh
source utils/install.sh

# [web server]
source ./nginx.sh

# [jekyll deps]
pkg_install gcc ruby ruby-devel rubygems
if [ "$OS_NAME" == "fedora" ]; then
  pkg_install redhat-rpm-config
fi

# [jekyll]
sudo gem install jekyll

# [example use]
# create files and dirs as shown here: http://jekyllrb.com/docs/structure/
# $ jekyll new blog
# .
# ├── _config.yml
# ├── _drafts
# |   ├── begin-with-the-crazy-ideas.textile
# |   └── on-simplicity-in-technology.markdown
# ├── _includes
# |   ├── footer.html
# |   └── header.html
# ├── _layouts
# |   ├── default.html
# |   └── post.html
# ├── _posts
# |   ├── 2007-10-29-why-every-programmer-should-play-nethack.textile
# |   └── 2009-04-26-barcamp-boston-4-roundup.textile
# ├── _data
#     |   └── members.yml
#     ├── _site
#     ├── .jekyll-metadata
#     └── index.html

# test server http://localhost:4000/
# automatically watches directory for changes
# $ jekyll serve # optional --no-watch --detach

# deploy
# $ jekyll build --source ~/blog --destination /var/www/html
