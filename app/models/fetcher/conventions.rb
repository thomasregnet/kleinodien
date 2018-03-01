module Fetcher
  # Naming conventions for fetchers
  class Conventions
    attr_reader :fetcher_name
    DELIMITER_STRING     = ':'.freeze
    KEY_NAME_PREFIX      = 'data'.freeze
    MESSAGE_QUEUE_SUFFIX = 'messages'.freeze

    def self.key_name_for(suffix)
      new.key_name_for(suffix)
    end

    def self.message_queue_name_for(fetcher_name)
      new(fetcher_name: fetcher_name).message_queue_name
    end

    def initialize(args = {})
      @fetcher_name = args[:fetcher_name]
    end

    def key_name_for(unique_string)
      concatenate [KEY_NAME_PREFIX, unique_string]
    end

    def message_queue_name
      raise 'name of the fetcher not given' unless fetcher_name
      concatenate [fetcher_name, MESSAGE_QUEUE_SUFFIX]
    end

    private

    def concatenate(strings)
      strings.join(DELIMITER_STRING)
    end
  end
end
