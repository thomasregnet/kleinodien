# frozen_string_literal: true

# Subscribe to an import queue
class ImportQueueSubscribeBase < ImportQueueBase
  define_singleton_method(:importer_class) do |value|
    define_method(:importer_class) { value.to_s }
  end
end
