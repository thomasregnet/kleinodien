class RenameHeapHeadsToReleaseHeads < ActiveRecord::Migration[6.0]
  def change
    rename_table :heap_heads, :release_heads

    rename_column :heaps, :heap_head_id, :release_head_id
  end
end
