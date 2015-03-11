module ImdbTestHelper
  def self.get_movie_data(name)
    File.open(File.join('fixtures', 'imdb', name)).read
  end

  def self.get_season_data(name)
    File.open(File.join('fixtures', 'imdb', 'episodes', name)).read
  end
end
