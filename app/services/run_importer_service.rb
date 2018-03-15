class RunImporterService
  include CallWithArgs

  private

  attr_reader :importer_name

  def initialize(importer_name)
    @importer_name = importer_name

  end

  def private_call
    redis = ImportConnection.redis

    redis.subscribe(importer_name) do |on|
      puts "subscribing to #{importer_name}"
      on.message do |channel, message|
        puts "#{channel}: #{message}"
      end
    end
  end
end
