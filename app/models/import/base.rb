module Import
  # Base class for import, prepare and persist
  class Base
    attr_reader :store, :params, :reference

    def initialize(args = {})
      @params     = args[:params]
      @store      = init_store(args)
      @reference  = init_reference(args)
    end

    def offered
      return unless params
      params.dig(:data, :attributes, :offered)
    end

    def attributes
      return unless params
      params.dig(:data, :attributes)
    end

    alias ask store

    private

    def init_store(args)
      store = args[:store]
      return store if store

      #return Store.new(having: attributes[:knowledge]) if attributes
      return Store.from_uris(attributes[:knowledge]) if attributes

      Store.new
    end

    def init_reference(args)
      reference = args[:reference]
      return reference if reference

      reference_class = args[:reference_class]
      return unless reference_class
      reference_class.new(code: offered)
    end

    def method_missing(method, args = {})
      class_name = import_service_class_name_for(method)
      if Import.const_defined?(class_name)
        klass = class_name.constantize
        merged_args = { store: store }.merge(args)
        return klass.send :perform, merged_args
      end
      super
    end

    def respond_to_missing?(method_name, _, &_block)
      class_name = import_service_class_name_for(method_name)
      Import.const_defined?(class_name)
    end

    def import_service_class_name_for(method)
      "Import::#{method.to_s.camelize}"
    end
  end
end
