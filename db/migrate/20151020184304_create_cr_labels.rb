class CreateCrLabels < ActiveRecord::Migration[4.2]
  def change
    create_table :cr_labels do |t|
      t.references :compilation_release, index: true, foreign_key: true, null: false
      t.references :company, index: true, foreign_key: true, null: false
      t.string :catalog_no

      t.timestamps null: false
    end
  end
end
