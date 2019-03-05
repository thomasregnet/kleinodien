#!/usr/bin/env ruby
# frozen_string_literal: true

require 'csv'
require 'multi_json'

tsv_file = ARGV[0]
tsv_args = {
  col_sep:    "\t",
  quote_char: '~' # something unusual to prevent errors with '"'
}

formats = CSV.readlines(tsv_file, tsv_args).map do |row|
  {
    name:        row[1],
    explanation: row[6],
    year:        row[4],
    brainz_code: row[7]
  }
end

puts MultiJson.dump(formats, pretty: true)
