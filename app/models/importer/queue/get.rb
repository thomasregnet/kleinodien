module Importer
  module Queue
    # Get contents from web apis
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
        Faraday.get(uri)
      end
    end
  end
end
