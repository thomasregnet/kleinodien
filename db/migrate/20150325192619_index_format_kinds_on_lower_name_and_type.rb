class IndexFormatKindsOnLowerNameAndType < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_format_kinds_on_lower_name_and_type
            ON format_kinds (LOWER(name), type);
        DDL
      end
      idx.down do
        remove_index(
          :format_kinds, name: :index_format_kinds_on_lower_name_and_type)
      end
    end
  end
end
