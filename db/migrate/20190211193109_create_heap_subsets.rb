class CreateHeapSubsets < ActiveRecord::Migration[5.2]
  def change
    create_table :heap_subsets do |t|
      t.integer :no, null: false
      t.string :title
      t.references :heap, foreign_key: true, null: false

      t.timestamps
    end
  end
end
