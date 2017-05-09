class CreateCrFormatKinds < ActiveRecord::Migration[4.2]
  def change
    create_table :cr_format_kinds do |t|
      t.string :name, null: false
      t.string :abbr
      t.string :note

      t.timestamps null: false
    end
  end
end
