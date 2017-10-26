# Fetch test Data
module KoTestData
  BRAINZ_FIXTURES = %w[fixtures brainz].freeze

  # TODO: Delete methods brainz_release and brainz_artist. Use brainz_xml_for
  # instead
  def self.brainz_release(foreign_id)
    brainz_xml_for(foreign_id)
  end

  def self.brainz_artist(foreign_id)
    brainz_xml_for(foreign_id)
  end

  def self.brainz_xml_for(foreign_id)
    path = [BRAINZ_FIXTURES, foreign_id.cache_key + '.xml']
    file_name = File.join(path.flatten)
    File.open(file_name).read
  end

  def self.store_brainz_cache(foreign_id, cache)
    xml = brainz_xml_for(foreign_id)
    cache.store_brainz(foreign_id, xml)
  end
end
