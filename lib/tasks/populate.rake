require_relative '../../spec/discogs_test_helper'
require_relative '../../spec/imdb_test_helper'

namespace :db do
  desc 'fill the database with sample data'
  task :populate => :environment do
    # TODO: users

    discogs_releases = [4298844, 4462260, 940468]
    discogs_releases.each do |r|
      DiscogsTestHelper.import_release(r)
    end

    # movie
    ImdbImporter.import_movie(ImdbTestHelper.get_movie_data('tt0079470.html'))

    #serial
    html = ImdbTestHelper.get_movie_data('tt0106179.html')
    serial = ImdbImporter.import_tv_serial(html)

    html = ImdbTestHelper.get_season_data('tt0106179-1.html')
    ImdbImporter.import_tv_serial_season(serial, 1, html)
  end
end

