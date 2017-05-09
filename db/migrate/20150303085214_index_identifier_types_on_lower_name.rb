class IndexIdentifierTypesOnLowerName < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_identifier_types_on_lower_name
            ON identifier_types (LOWER(name));
        DDL
      end
      idx.down do
        remove_index(:identifier_types,
                     name: :index_identifier_types_on_lower_name)
      end
    end
  end
end
