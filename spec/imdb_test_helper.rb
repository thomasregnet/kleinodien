module ImdbTestHelper
  def self.get_movie_data(name)
    File.open(File.join('fixtures', 'imdb', name)).read
  end
end
