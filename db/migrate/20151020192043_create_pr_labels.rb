class CreatePrLabels < ActiveRecord::Migration
  def change
    create_table :pr_labels do |t|
      t.references :piece_release, index: true, foreign_key: true, null: false
      t.references :company, index: true, foreign_key: true, null: false
      t.string :catalog_no

      t.timestamps null: false
    end
  end
end
