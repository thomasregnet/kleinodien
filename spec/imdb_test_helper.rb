module ImdbTestHelper
  def self.get_movie_data(name)
    File.open(File.join('fixtures', 'imdb', 'movies', name)).read
  end
end
