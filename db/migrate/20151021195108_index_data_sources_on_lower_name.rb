class IndexDataSourcesOnLowerName < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_data_sources_on_lower_name
            ON data_sources (LOWER(name));
        DDL
      end
      idx.down do
        remove_index :data_sources, name: :index_data_sources_on_lower_name
      end
    end
  end
end
