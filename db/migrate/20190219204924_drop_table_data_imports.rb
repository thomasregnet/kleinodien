class DropTableDataImports < ActiveRecord::Migration[5.2]
  def change
    remove_column :artist_credits, :data_import_id
    remove_column :artists, :data_import_id
    remove_column :compilation_heads, :data_import_id
    remove_column :compilation_releases, :data_import_id
    drop_table :data_imports
  end
end
