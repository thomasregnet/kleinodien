class CreatePhLabels < ActiveRecord::Migration
  def change
    create_table :ph_labels do |t|
      t.references :piece_head, index: true, foreign_key: true
      t.references :company, index: true, foreign_key: true
      t.string :catalog_no

      t.timestamps null: false
    end
  end
end
