module LayeredImport
  class ScraperBuilder
    def self.build
      builder = new
      yield builder

      callbacks = builder.callbacks.freeze
      LayeredImport::Scraper.new(callbacks)
    end

    def always(attr, default = nil)
      callbacks[attr] = ->(_) { default }
    end

    def callback(attr, callable)
      callbacks[attr] = callable
    end

    def dig(attr, *keys)
      keys = attr if keys.none?

      callbacks[attr] = ->(data) { data.dig(*keys) }
    end

    def initialize
      @callbacks = {}
    end

    attr_reader :callbacks
  end
end
