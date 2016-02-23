class IndexCrfAttributeKindsOnLowerName < ActiveRecord::Migration
  def change
     reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_crf_attribute_kinds_on_lower_name
            ON crf_attribute_kinds (LOWER(name));
        DDL
      end
      idx.down do
        remove_index(
          :crf_attribute_kinds,
          name: :index_crf_attribute_kinds_on_lower_name
        )
      end
    end
  end
end
