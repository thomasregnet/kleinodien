# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Source.create!(
  name:        'MusicBrainz',
  description: 'An open music encyclopedia that collects music metadata'
)

Source.create!(
  name:        'Discogs',
  description: 'Discover new music'
)

Source.create!(
  name:        'Omdb',
  description: 'omdb (open media database) is a free database for film media'
)

Source.create!(
  name:        'User',
  description: 'User contributed data'
)
