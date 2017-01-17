class CreateOriginalExemplars < ActiveRecord::Migration[5.0]
  def change
    create_table :original_exemplars do |t|
      t.references :compilation_release, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.text :disambiguation, null: false

      t.timestamps
    end
  end
end
