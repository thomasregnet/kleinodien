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

    Rake::FileList.new('fixtures/discogs/releases/*.json').each do |file|
      m = /\/(\d+)\.json$/.match(file.to_s)
      DiscogsTestHelper.import_release(m[1].to_i)
    end

    # imdb-movie
    ImdbImporter.import_movie(ImdbTestHelper.get_movie_data('tt0079470.html'))

    # omdb-movies
    Rake::FileList.new('fixtures/omdb/movie/*.xml').each do |file|
      m = /\/(\d+)\.xml$/.match(file.to_s)
      OmdbTestHelper.import_movie(m[1].to_i)
    end

    #serial
    html = ImdbTestHelper.get_movie_data('tt0106179.html')
    serial = ImdbImporter.import_tv_serial(html)

    html = ImdbTestHelper.get_season_data('tt0106179-1.html')
    ImdbImporter.import_tv_serial_season(serial, 1, html)
  end
end

