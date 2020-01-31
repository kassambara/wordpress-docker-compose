#!/bin/sh
set -euo pipefail

# Based on wordpress:cli entrypoint
# https://github.com/docker-library/wordpress/blob/master/php7.2/cli/docker-entrypoint.sh

# If the first arg is `--some-option` then execute wp-cli
if [ "${1#-}" != "$1" ]; then
	set -- wp "$@"
fi

# if our command is a valid wp-cli subcommand (say plugin), let's invoke it through wp-cli instead
# (this allows for "docker run wordpress:cli help", etc)
# documenation of the subcommand is shown
if wp --path=/dev/null help "$1" > /dev/null 2>&1; then
	set -- wp "$@"
fi

# Execute aliases in the make file or directly the provided command
if [ "$1" == "install" ] || [ "$1" == "configure" ]; then
  make -f /scripts/Makefile $1
else
  exec "$@"
fi


