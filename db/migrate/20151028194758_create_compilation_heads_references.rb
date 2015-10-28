class CreateCompilationHeadsReferences < ActiveRecord::Migration
  def change
    create_table :compilation_heads_references, id: false do |t|
      t.references :compilation_head, index: true, foreign_key: true, null: false
      t.references :reference, index: true, foreign_key: true, null: false
    end
  end
end
