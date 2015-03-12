require_relative '../../spec/discogs_test_helper'
namespace :db do
  desc 'fill the database with sample data'
  task :populate => :environment do
    # TODO: users

    discogs_releases = [4298844, 4462260, 940468]
    discogs_releases.each do |r|
      DiscogsTestHelper.import_release(r)
    end
  end
end

