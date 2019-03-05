class CreateMediumFormats < ActiveRecord::Migration[5.2]
  def change
    create_table :medium_formats do |t|
      t.text :name, null: false
      t.text :explanation
      t.integer :year, limit: 2
      t.uuid :brainz_code
      t.references :import_order, foreign_key: true

      t.timestamps
    end
  end
end
