class IndexFormatsOnLowerName < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_formats_on_lower_name
            ON formats (LOWER(name));
        DDL
      end
      idx.down do
        remove_index(:formats, name: :index_formats_on_lower_name)
      end
    end
  end
end
