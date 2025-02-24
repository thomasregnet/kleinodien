module Import
  class RecordFinder
    def initialize(adapter_layer, kind, options)
      @adapter_layer = adapter_layer
      @kind = kind
      @options = options
    end

    def find
      finder_class.new(order, facade: facade).find
    end

    private

    attr_reader :adapter_layer, :kind, :options
    delegate_missing_to :adapter_layer

    def facade
      @facade ||= facade_layer.build_facade(reflections, options)
    end

    def finder_class
      @finder_class ||= "Import::#{reflections.base_class.name}Finder".constantize
    end

    def reflections
      @reflections ||= "Import::#{kind.to_s.classify}Reflections".constantize.new
    end
  end
end
