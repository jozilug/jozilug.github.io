Hello,

This repository contains the source files needed to build the website
for the Johannesburg Linux User Group (JoziLUG):
[http://www.jozilug.co.za](http://www.jozilug.co.za).  The site is
built using [Jekyll](http://jekyllrb.com/), a static site generator
written in Ruby, and uses the [Bootstrap](http://getbootstrap.com/)
framework.  It is hosted using GitHub Pages.

In order to test the site on your own computer, you will first need to
install Jekyll.  To do this you will need to have git, ruby
development tools, and ([for the time
being](https://github.com/jekyll/jekyll/issues/2327#issuecomment-55337023))
nodejs installed:

    sudo apt-get install git ruby-dev nodejs

You will then need to run:

    gem install jekyll

From the root directory of the site, run ``jekyll build`` to output
the site to the _site subdirectory.  Run ``jekyll serve`` to see the
site hosted locally at 0.0.0.0:4000.

Cheers!