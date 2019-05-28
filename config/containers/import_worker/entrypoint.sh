#!/usr/bin/env bash

exec bundle exec rails runner lib/init_import_worker.rb
