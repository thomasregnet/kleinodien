#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../../app/models', __FILE__)

require 'redis'
require 'fetcher'

$stdout.sync = true

Fetcher.run('brainz')
