module Importer
  module Queue
    class Settings
      mattr_accessor :name, instance_writer: false

      def self.fetcher_name
        name
      end

      def fetcher_name
        name
      end
    end
  end
end
