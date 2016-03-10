# Data Source for db entries
class Source < ActiveRecord::Base
  self.primary_key = 'name'

  Discogs     = find('Discogs')
  MusicBrainz = find('MusicBrainz')
  Omdb        = find('Omdb')
  User        = find('User')
end
