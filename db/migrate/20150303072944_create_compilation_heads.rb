class CreateCompilationHeads < ActiveRecord::Migration[4.2]
  def change
    create_table :compilation_heads do |t|
      t.integer :artist_credit_id
      t.string :title, null: false
      t.string :disambiguation
      t.string :type

      t.timestamps null: false
    end
  end
end
