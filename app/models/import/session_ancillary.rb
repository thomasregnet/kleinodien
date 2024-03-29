module Import
  class SessionAncillary
    def initialize(factory)
      @factory = factory
    end

    delegate :buffered?, to: :buffer

    def deep_dup_buffer
      buffer.deep_dup
    end

    def get(kind, code)
      buffer.fetch(kind, code) || fetch(kind, code)
    end

    private

    attr_reader :factory
    delegate_missing_to :factory

    def fetch(kind, code)
      uri_string = build_uri_string(kind, code)
      fetcher = build_fetcher(uri_string)
      buffer.fetch(kind, code) { fetcher.get }
    end
  end
end
