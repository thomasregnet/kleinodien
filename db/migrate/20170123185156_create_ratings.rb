class CreateRatings < ActiveRecord::Migration[5.0]
  def change
    create_table :ratings do |t|
      t.integer :value, limit: 1, null: false
      t.references :user, foreign_key: true, null: false

      t.references :artist_credit,       foreign_key: true
      t.references :artist,              foreign_key: true
      t.references :compilation_head,    foreign_key: true
      t.references :compilation_release, foreign_key: true
      t.references :piece_head,          foreign_key: true
      t.references :piece_release,       foreign_key: true
      t.references :season,              foreign_key: true
      t.references :serial,              foreign_key: true
      t.references :station,             foreign_key: true
      t.timestamps
    end
  end
end

# artist_credits
# artists
# compilation_heads
# compilation_releases
# piece_heads
# piece_releases
# seasons
# serials
# stations
