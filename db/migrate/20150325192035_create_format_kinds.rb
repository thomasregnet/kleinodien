class CreateFormatKinds < ActiveRecord::Migration[4.2]
  def change
    create_table :format_kinds do |t|
      t.string :name, null: false
      t.string :abbr
      t.string :note
      t.string :type, null: false

      t.timestamps null: false
    end
  end
end
