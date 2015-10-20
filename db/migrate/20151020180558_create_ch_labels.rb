class CreateChLabels < ActiveRecord::Migration
  def change
    create_table :ch_labels do |t|
      t.references :compilation_head, index: true, foreign_key: true, null: false
      t.references :company, index: true, foreign_key: true, null: false
      t.string :catalog_no

      t.timestamps null: false
    end
  end
end
