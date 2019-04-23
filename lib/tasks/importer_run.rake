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

    import_order_class = ENV['IMPORT_ORDER_CLASS'].constantize
    queue_name = ENV['IMPORT_ORDER_CLASS'].constantize.import_queue_name

    # puts "listening to orders on \"#{queue_name}\""
    # ImportQueue.subscribe(queue_name: queue_name)

    worker = ImportWorker.new(import_order_class: import_order_class)
    worker.perform

    loop { sleep 5 }
  end
end
