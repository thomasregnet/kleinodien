# Data Source for db entries
class Source < ActiveRecord::Base
  Discogs     = find_by(name: 'Discogs')
  MusicBrainz = find_by(name: 'MusicBrainz')
  Omdb        = find_by(name: 'Omdb')
  User        = find_by(name: 'User')
end
