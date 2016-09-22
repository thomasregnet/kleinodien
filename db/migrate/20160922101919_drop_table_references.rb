class DropTableReferences < ActiveRecord::Migration[5.0]
  def change
    drop_table :references
  end
end
