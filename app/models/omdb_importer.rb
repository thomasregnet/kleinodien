class OmdbImporter < ActiveRecord::Base
  def self.import_movie(xml)
    omdb_movie = KleinodienOmdb.parse_movie(xml)
    MovieHead.create!(title: omdb_movie.name)
  end
end
