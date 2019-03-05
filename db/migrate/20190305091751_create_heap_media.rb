class CreateHeapMedia < ActiveRecord::Migration[5.2]
  def change
    create_table :heap_media do |t|
      t.integer :position, limit: 2, null: false
      t.integer :quantity, limit: 2, null: false
      t.references :heap, foreign_key: true, null: false
      t.references :medium_format, foreign_key: true, null: false

      t.timestamps
    end
  end
end
