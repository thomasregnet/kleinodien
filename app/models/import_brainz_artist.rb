class ImportBrainzArtist
  attr_reader :brainz_id, :cache

  def self.perform(id, cache)
    new(id, cache).perform
  end

  def initialize(id, cache)
    @brainz_id = BrainzArtistId.new(id)
    @cache     = cache
  end

  def perform
    source_id = brainz_id.source_id
    return if cache.required['brainz'].include? source_id
    cache.require_brainz source_id
  end
end
