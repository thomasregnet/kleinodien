module LayeredImport::Concerns
  module RecordBuildable
    extend ActiveSupport::Concern

    def build_has_many_records
      reflections.has_many_associations.map do |association|
        create_has_many_builder(association, facade, record).build_many
      end
    end

    def assign_foreign_attributes
      reflections.belong_to_associations.each do |association|
        adapter_layer.create_foreign_attribute_assigner(association, facade, record).assign
      end
    end

    def inherent_attributes
      reflections.inherent_attribute_names.index_with { |attr| facade.send(attr) }.compact
    end
  end
end
