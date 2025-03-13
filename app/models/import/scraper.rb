module Import
  class Scraper
    def initialize(callbacks, facade)
      @callbacks = callbacks
      @facade = facade
    end

    attr_reader :callbacks, :facade

    def scrape(attr)
      callback = callbacks[attr]
      raise ArgumentError, "don't know how to scrape :#{attr} from #{facade.class}" unless callback

      callback.call(facade)
    end

    def scrape_many(*attrs)
      attrs.flatten.index_with { |attr| scrape(attr) }.with_indifferent_access
    end
  end
end
