class CreateFormatKinds < ActiveRecord::Migration
  def change
    create_table :format_kinds do |t|
      t.string :name
      t.string :abbr
      t.string :note
      t.string :type

      t.timestamps null: false
    end
  end
end
