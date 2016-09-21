class DropTableCompilationHeadsReferences < ActiveRecord::Migration[5.0]
  def change
    drop_table :compilation_heads_references
  end
end
