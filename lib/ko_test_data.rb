# frozen_string_literal: true

# Fetch test Data
module KoTestData
  class GetBrainzXmlFor
    BRAINZ_DATA = %w[fixtures musicbrainz.org].freeze

    def self.path(path)
      new(path).get
    end

    def initialize(path)
      @path = path
    end

    attr_reader :path

    def get
      File.open(file_name).read
    end

    def file_name
      File.join(BRAINZ_DATA, path)
      # path = uri.path.sub(%r{^.*ws/2/}, '') + '?' + uri.query
      # File.join(BRAINZ_DATA, path) + '.xml'
    end
  end
  # Get MusicBrainz blueprints
  class GetBrainzBlueprintFor
    BRAINZ_DATA = %w[fixtures musicbrainz.org].freeze

    def self.request(request)
      new(request.to_uri).get
    end

    def self.uri(uri)
      new(uri).get
    end

    def self.path(path)
      new(path).get
    end

    def initialize(uri)
      #@uri = URI(uri)
      @path = uri # TODO: !!!
    end

    attr_reader :uri, :path

    def get
      xml = File.open(file_name).read
      BrainzBlueprint.from_xml(xml)
    end

    def file_name
      File.join(BRAINZ_DATA, path)
      # path = uri.path.sub(%r{^.*ws/2/}, '') + '?' + uri.query
      # File.join(BRAINZ_DATA, path) + '.xml'
    end
  end

  # TODO: the code behind this comment is old and should be deleted sometime
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
