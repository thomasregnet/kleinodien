class IndexTrfAttributeKindsOnLowerName < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_trf_attribute_kinds_on_lower_name
            ON trf_attribute_kinds (LOWER(name));
        DDL
      end
      idx.down do
        remove_index(
          :trf_attribute_kinds,
          name: :index_trf_attribute_kinds_on_lower_name
        )
      end
    end
  end
end
