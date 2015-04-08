class CreateTrFormatKinds < ActiveRecord::Migration
  def change
    create_table :tr_format_kinds do |t|
      t.string :name, null: false
      t.string :abbr
      t.string :note

      t.timestamps null: false
    end
  end
end
