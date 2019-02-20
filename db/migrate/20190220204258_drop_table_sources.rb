class DropTableSources < ActiveRecord::Migration[5.2]
  def change
    remove_column :artist_credits, :source_id
    remove_column :descriptions, :source_id
    drop_table :sources
  end
end
