#!/bin/sh

source ./config.sh
source utils/install.sh

# [web server]
source ./nginx.sh

# [jekyll deps]
pkg_install gcc ruby ruby-devel rubygems

# [jekyll]
sudo gem install jekyll

# [example use]
# mkdir ~/blog
# create files and dirs as shown here: http://jekyllrb.com/docs/structure/
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

# jekyll build --source ~/blog --destination /var/www/html
