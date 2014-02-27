Hello,

This repository contains the source files needed to build the website
for the Johannesburg Linux User Group (JoziLUG):
[http://www.jozilug.co.za](http://www.jozilug.co.za)

You'll need the following ruby gems for the site to build properly: 

* rmagick
* optipng
* markaby
* exifr
* rmeetup

You will also need to create a file called ``_secrets.yml`` in the
root directory of the site populated with your Meetup API key.  You
can generate this key by going
(here)[https://secure.meetup.com/meetup_api/key/].  The contents of
this file should look like ``meetup_api_key: [your key here]``.

From the root directory of the site, run ``jekyll build --serve`` to
see the site hosted locally at 0.0.0.0:4000.

Cheers!


