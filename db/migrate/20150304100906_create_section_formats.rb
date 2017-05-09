class CreateSectionFormats < ActiveRecord::Migration[4.2]
  def change
    create_table :section_formats do |t|
      t.string :name, null: false
      t.string :abbr, null: false
      t.string :explanation
      t.integer :rpm

      t.timestamps null: false
    end
  end
end
