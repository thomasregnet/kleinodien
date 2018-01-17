module Import
  # Known and required data to import
  class Store
    attr_reader :having, :missing

    def self.from_uris(uri_data)
      return new unless uri_data
      having = {}
      uri_data.each do |uri, data|
        having[::UriToReference.perform(uri)] = data
      end
      new(having: having)
    end

    def initialize(args = {})
      @having  = args[:having] || {}
      @missing = Set.new
    end

    def request_raw(reference)
      raw_data = having[reference]
      unless raw_data
        missing.add(reference)
        return
      end

      raw_data
    end

    def request(reference)
      raw_data = request_raw(reference)
      return unless raw_data
      PrepareRawData.perform(reference, raw_data)
    end

    def request!(reference)
      response = request(reference)
      raise KnowledgeMissing unless response
      response
    end

    def collect
      {
        required: collect_required
      }
    end

    def collect_required
      required = {}
      missing.each do |reference|
        category = reference.category
        list = required[category] ||= []
        list << reference.to_uri
      end
      required
    end

    def missing?
      !missing.empty?
    end
  end
end
