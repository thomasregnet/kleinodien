# frozen_string_literal: true

# This file should contain all the record creation needed to seed the
# database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside
# the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'multi_json'

@formats = MultiJson.load(
  File.read('db/seeds/formats.json'),
  symbolize_keys: true
)

@format_details = MultiJson.load(
  File.read('db/seeds/format_details.json'),
  symbolize_keys: true
)

@formats.each do |format|
  Format.create!(
    name: format[:name],
    abbr: format[:abbr]
  )
end

@format_details.each do |detail|
  FormatDetail.create!(
    name: detail[:name],
    abbr: detail[:abbr]
  )
end

@medium_formats = MultiJson.load(
  File.read('db/seeds/medium_formats.json'),
  symbolize_keys: true
)

@medium_formats.each do |format_attr|
  MediumFormat.create!(format_attr)
end
