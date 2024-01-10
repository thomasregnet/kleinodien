module Import
  class Fetcher
    def initialize(factory:, uri:)
      @factory = factory
      @uri = uri
    end

    def get
      max_tries.times do
        response = attempt
        return response.body if response
      end

      raise "can't get #{uri}"
    end

    private

    attr_reader :factory, :uri

    delegate_missing_to :factory

    def attempt
      attempt = build_attempt
      attempt.get(uri)
    end
  end
end
