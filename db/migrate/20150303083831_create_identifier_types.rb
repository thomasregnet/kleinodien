class CreateIdentifierTypes < ActiveRecord::Migration
  def change
    create_table :identifier_types do |t|
      t.string :name, null: false
      t.string :explanation

      t.timestamps null: false
    end
  end
end
