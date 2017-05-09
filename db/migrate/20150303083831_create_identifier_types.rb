class CreateIdentifierTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :identifier_types do |t|
      t.string :name, null: false
      t.string :explanation

      t.timestamps null: false
    end
  end
end
