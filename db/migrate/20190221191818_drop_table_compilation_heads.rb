class DropTableCompilationHeads < ActiveRecord::Migration[5.2]
  def change
    # dependant columns
    remove_column :comments, :heap_head_id
    remove_column :descriptions, :compilation_head_id
    remove_column :ratings, :compilation_head_id

    # dependant tables
    drop_table :compilation_heads_countries
    drop_table :ch_labels
    drop_table :ch_credits
    drop_table :compilation_heads_tags
    drop_table :ch_companies

    # in the end ...
    drop_table :compilation_heads
  end
end
