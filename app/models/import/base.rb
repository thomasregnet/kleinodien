module Import
  # Base class for import, prepare and persist
  class Base
    attr_reader :knowledge, :params, :reference

    def initialize(args = {})
      #@data_import = args[:data_import]
      @params      = args[:params]
      @knowledge   = args[:knowledge] || Import::Knowledge.new(attributes)
      @reference   = init_reference(args)
    end

    def wanted
      return unless params
      params.dig(:data, :attributes, :wanted)
    end

    def attributes
      return unless params
      params.dig(:data, :attributes)
    end

    # def data_import
    #   @data_import ||= ::DataImport.create!(note: 'foobar')
    # end

    alias ask knowledge

    private

    def init_reference(args)
      reference = args[:reference]
      return reference if reference

      reference_class = args[:reference_class]
      return unless reference_class
      reference_class.new(code: wanted)
    end

    def method_missing(method, args = {})
      class_name = import_service_class_name_for(method)
      if Import.const_defined?(class_name)
        klass = class_name.constantize
        merged_args = { knowledge: knowledge}.merge(args)
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
