# frozen_string_literal: true

# Fetch test Data
module KoTestData
  BRAINZ_FIXTURES = %w[fixtures].freeze # brainz].freeze

  # TODO: Delete methods brainz_release and brainz_artist. Use brainz_xml_for
  # instead
  def self.brainz_release(reference)
    brainz_xml_for(reference)
  end

  def self.brainz_artist(reference)
    brainz_xml_for(reference)
  end

  def self.brainz_xml_for(reference)
    path = [BRAINZ_FIXTURES, reference.to_key]
    file_name = File.join(path.flatten) + '.xml'
    File.open(file_name).read
  end

  def self.store_brainz_cache(reference, cache)
    xml = brainz_xml_for(reference)
    cache.store_brainz(reference, xml)
  end
end
