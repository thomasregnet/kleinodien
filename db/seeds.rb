# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# The SourceSeed class is necessary because the really class, "Source",
# ties to get domain data from the db which must be created here
require 'multi_json'

class SourceSeed < ActiveRecord::Base
  self.table_name  = 'sources'
  self.primary_key = 'name'
end

SourceSeed.create!(
  name:        'MusicBrainz',
  description: 'An open music encyclopedia that collects music metadata'
)

SourceSeed.create!(
  name:        'Discogs',
  description: 'Discover new music'
)

SourceSeed.create!(
  name:        'Omdb',
  description: 'omdb (open media database) is a free database for film media'
)

SourceSeed.create!(
  name:        'User',
  description: 'User contributed data'
)

@formats = MultiJson.load(
  File.read('db/seeds/formats.json'),
  symbolize_keys: true
)

@formats.each do |format|
  Format.create!(
    name: format[:name],
    abbr: format[:abbreviation],
  )
end
