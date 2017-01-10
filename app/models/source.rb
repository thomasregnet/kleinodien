# Data Source for db entries
class Source < ActiveRecord::Base
  #self.primary_key = 'name'

  Discogs     = find_by(name: 'Discogs')
  MusicBrainz = find_by(name: 'MusicBrainz')
  Omdb        = find_by(name: 'Omdb')
  User        = find_by(name: 'User')
end
