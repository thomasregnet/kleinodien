#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../../../../app/models', __FILE__)

require 'redis'
require 'import/queue'

$stdout.sync = true

Import::Queue.run(ENV['FETCHER_NAME'])
