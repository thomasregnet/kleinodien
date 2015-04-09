class CreateCrfAttributeKinds < ActiveRecord::Migration
  def change
    create_table :crf_attribute_kinds do |t|
      t.string :name, null: false
      t.string :abbr
      t.string :note

      t.timestamps null: false
    end
  end
end
