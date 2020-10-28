class CreateReleaseCopies < ActiveRecord::Migration[6.0]
  def change
    create_table :release_copies do |t|
      t.text :type
      t.references :release_head, foreign_key: true
      t.references :release, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
