namespace :import do
  desc 'run an import queue'
  task :run_queue => :environment do
    $stdout.sync = true

    if ENV['RAILS_ENV'] && ENV['RAILS_ENV'] == 'test'
      require 'fake_music_brainz'
      require 'webmock'
      include WebMock::API
      WebMock.enable!

      WebMock.stub_request(:any, /musicbrainz.org/).to_rack(FakeMusicBrainz)
    end

    Importer::Queue.run(ENV['IMPORT_QUEUE_NAME'])
  end
end
