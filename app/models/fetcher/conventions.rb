module Fetcher
  # Naming conventions for fetchers
  module Conventions
    KEY_NAME_PREFIX      = 'data'.freeze
    MESSAGE_QUEUE_SUFFIX = 'messages'.freeze

    def self.key_name_for(suffix)
      "#{KEY_NAME_PREFIX}:#{suffix}"
    end

    def self.message_queue_name_for(fetcher_name)
      "#{fetcher_name}:#{MESSAGE_QUEUE_SUFFIX}"
    end
  end
end
