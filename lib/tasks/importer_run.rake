namespace :importer do
  desc 'run an import queue'
  task :run => :environment do
    $stdout.sync = true

    if ENV['RAILS_ENV'] == 'test'
      require 'fake_music_brainz'
      require 'webmock'
      include WebMock::API
      WebMock.enable!

      WebMock.stub_request(:any, /musicbrainz.org/).to_rack(FakeMusicBrainz)
    end

    RunImporterService.call(importer_name: ENV['IMPORTER_NAME'])
  end
end
