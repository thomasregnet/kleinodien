class CreateTags < ActiveRecord::Migration[5.0]
  def change
    create_table :tags do |t|
      t.text :name, null: false
      t.text :note

      t.timestamps
    end

    add_index :tags, :name, unique: true
  end
end
