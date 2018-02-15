#!/usr/bin/env bash

echo "Removing unicorn pidfile"
rm -rf tmp/pids/unicorn.pid

# http://chrisstump.online/2016/02/20/docker-existing-rails-application/
# Prefix `bundle` with `exec` so unicorn shuts down
# gracefully on SIGTERM (i.e. `docker stop`)
exec bundle exec unicorn -c config/containers/unicorn.rb -E $RAILS_ENV;
