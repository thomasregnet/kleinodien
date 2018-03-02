module Fetcher
  class Get
    attr_reader :uri

    def self.perform(args)
      new(args).perform
    end

    def initialize(args)
      @uri = args[:uri]
    end

    def perform
      # TODO: return some real data
      Faraday::Response.new
    end
  end
end
