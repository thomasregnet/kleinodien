class RunImporterService
  include CallWithArgs

  private

  attr_reader :importer_name, :prohibit_subscription

  def initialize(args)
    @importer_name         = args[:importer_name]
    @prohibit_subscription = args[:prohibit_subscription]
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
