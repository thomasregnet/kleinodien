require 'discogs_test_helper'
require 'omdb_test_helper'
require_relative '../../spec/imdb_test_helper'

namespace :db do
  desc 'fill the database with sample data'
  task :populate => :environment do

    password = 'topSecret'

    User.create!(
      email: 'user@example.com',
      password: password,
      password_confirmation: password
    )

    99.times do |n|
      User.create!(
        email: Faker::Internet.email,
        password: password,
        password_confirmation: password
      )
    end
    
    discogs_releases = [4298844, 4462260, 940468]
    discogs_releases.each do |r|
      DiscogsTestHelper.import_release(r)
    end

    # movie
    ImdbImporter.import_movie(ImdbTestHelper.get_movie_data('tt0079470.html'))

    # omdb
    Rake::FileList.new('fixtures/omdb/movie/*.xml') do |file|
      m = /\/(\d+)\.xml$/.match(file.to_s)
      id = m[1].to_i
      OmdbImporter.import_movie(OmdbTestHelper.import_movie(id))
    end

    #serial
    html = ImdbTestHelper.get_movie_data('tt0106179.html')
    serial = ImdbImporter.import_tv_serial(html)

    html = ImdbTestHelper.get_season_data('tt0106179-1.html')
    ImdbImporter.import_tv_serial_season(serial, 1, html)
  end
end

