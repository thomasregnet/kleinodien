class CreateDescriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :descriptions do |t|
      t.text       :text, null: false

      t.references :user,   foreign_key: true
      t.references :source, foreign_key: true

      t.references :artist_credit,       foreign_key: true
      t.references :artist,              foreign_key: true
      t.references :compilation_head,    foreign_key: true
      t.references :compilation_release, foreign_key: true
      t.references :country,             foreign_key: true
      t.references :piece_head,          foreign_key: true
      t.references :piece_release,       foreign_key: true
      t.references :season,              foreign_key: true
      t.references :serial,              foreign_key: true
      t.references :station,             foreign_key: true

      t.timestamps
    end
  end
end
