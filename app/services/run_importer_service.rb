class RunImporterService
  include CallWithArgs
  include ImportStoreCommons

  private

  attr_reader :importer_name, :subscription_prohibited

  def initialize(args)
    @importer_name           = args[:importer_name]
    @subscription_prohibited = args[:subscription_prohibited]
  end

  def private_call
    subscribe
  end

  def subscription_prohibited?
    # TODO: check if subscription is prohibited by a redis key
    subscription_prohibited
  end

  def subscribe
    return if subscription_prohibited?

    import_store.subscribe(importer_name) do |on|
      puts "subscribing to #{importer_name}"
      on.message do |channel, message|
        puts "#{channel}: #{message}"
      end
    end
  end
end
