namespace :import do
  desc 'run an import queue'
  task :run_queue => :environment do
    $stdout.sync = true
    Import::Queue.run(ENV['FETCHER_NAME'])
  end
end
