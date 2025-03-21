module Import
  class DelegatedBaseToDelegatedBaseAssigner
    include Callable

    def initialize(adapter_layer, association, entity, facade)
      @adapter_layer = adapter_layer
      @association = association
      @entity = entity
      @facade = facade
    end

    def call
      entity.send(association_writer, foreign_base)
    end

    private

    attr_reader :adapter_layer, :association, :entity, :facade
    delegate :name, to: :association, prefix: true
    delegate :delegated_base_reader, to: :association

    def association_writer
      "#{association_name}="
    end

    def foreign_base
      @foreign_base ||= delegated_type.send(delegated_base_reader)
    end

    def foreign_attributes
      facade.scrape(association_name)
    end

    def delegated_type
      adapter_layer.supply_entity(delegated_type_class, foreign_attributes)
    end

    def delegated_type_class
      association.delegated_class_for(entity)
    end
  end
end
