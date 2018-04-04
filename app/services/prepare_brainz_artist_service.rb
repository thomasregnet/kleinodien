class PrepareBrainzArtistService
  include CallWithArgs
  include ImportStore

  private

  attr_reader :importer_name, :reference

  def initialize(args)
    @importer_name = args[:importer_name]
    @reference     = args[:reference]
  end

  def private_call
    return true if already_imported?
    return true if already_cached?
    false
  end

  def already_imported?
    false
  end

  def already_cached?
    key = "cache:#{reference.to_uri}"
    return true if import_store.get(key)
    false
  end
end
