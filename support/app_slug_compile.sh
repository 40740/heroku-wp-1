#!/bin/bash

# Cleanup dirs
rm -rf tmp/public.building tmp/public.old

# Create base from composer installer
mv vendor/wordpress/wordpress tmp/public.building

# Recursively copy files build final web dir
cp -R public/* tmp/public.building

# Move built web dir into place
mkdir -p public.built
mv public.built tmp/public.old && mv tmp/public.building public.built
rm -rf tmp/public.old

# Remove files to slim down slug if we're on Heroku
if [ ! -e .sluglocal ]
then
	rm -rf vendor/wordpress
	rm -rf public
fi

# Write some info about our slug
NOW=$( date )
cat <<EOT > public.built/.heroku-wp
Powered by HerokuWP
https://github.com/xyu/heroku-wp
=============================================

Slug Compiled : $NOW
EOT
