module Import::Concerns
  module RecordBuildable
    extend ActiveSupport::Concern

    def build_has_many_records
      reflections.has_many_associations.map do |association|
        build_has_many_associations(association, facade, record)
      end
    end

    def assign_foreign_attributes
      reflections.belong_to_associations.each do |association|
        adapter_layer.assign_foreign_attribute(association, facade, record)
      end
    end

    def inherent_attributes
      names = reflections.inherent_attribute_names
      facade.scrape_many(names)
    end
  end
end
