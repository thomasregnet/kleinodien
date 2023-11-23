module Import
  class DomainBuffer
    def initialize(buffer, domain_key)
      @buffer = buffer
      @domain_key = domain_key
    end

    def fetch(*cache_key_parts, &block)
      buffer.fetch("musicbrainz.org", cache_key_parts, &block)
    end

    private

    attr_reader :buffer, :domain_key
  end
end
