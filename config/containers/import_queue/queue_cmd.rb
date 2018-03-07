#!/usr/bin/env ruby

# Load config/application to benefit from rails environment
require File.expand_path('../../../../config/application', __FILE__)

# require everything under app/models
Dir[File.expand_path('../../../../app/modeles', __FILE__)]
  .each { |file| require file }

# adopted from Rakefile
$LOAD_PATH.unshift File.expand_path('../../../../app/models', __FILE__)

require 'redis'
require 'import/queue'

$stdout.sync = true

Import::Queue.run(ENV['FETCHER_NAME'])
