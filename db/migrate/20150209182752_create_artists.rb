class CreateArtists < ActiveRecord::Migration[4.2]
  def change
    create_table :artists do |t|
      t.string :name, null: false
      t.string :disambiguation

      t.timestamps null: false
    end
  end
end
