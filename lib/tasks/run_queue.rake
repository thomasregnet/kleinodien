namespace :import do
  desc 'run an import queue'
  task :run_queue => :environment do
    $stdout.sync = true
    Importer::Queue.run(ENV['IMPORT_QUEUE_NAME'])
  end
end
