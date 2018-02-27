module Fetcher
  # Naming conventions for fetchers
  module Conventions
    MESSAGE_QUEUE_SUFFIX = 'messages'.freeze

    def self.message_queue_name_for(fetcher_name)
      "#{fetcher_name}:#{MESSAGE_QUEUE_SUFFIX}"
    end
  end
end
