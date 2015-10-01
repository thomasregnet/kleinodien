module OmdbTestHelper
  def self.import_movie(omdb_id)
    puts get_omdb_movie_data(omdb_id)
    OmdbImporter.import_movie(get_omdb_movie_data(omdb_id))
  end

  def self.get_omdb_movie_data(omdb_id)
    name = omdb_id.to_s + '.xml'
    File.open(File.join('fixtures', 'omdb', 'movie', name)).read
  end
end
