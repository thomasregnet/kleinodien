class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.text :comment, null: false
      t.references :user, foreign_key: true, null: false

      t.references :artist_credit,        foreign_key: true
      t.references :artist,               foreign_key: true
      t.references :compilation_heads,    foreign_key: true
      t.references :compilation_releases, foreign_key: true
      t.references :piece_heads,          foreign_key: true
      t.references :piece_releases,       foreign_key: true
      t.references :repositories,         foreign_key: true
      t.references :seasons,              foreign_key: true
      t.references :serials,              foreign_key: true
      t.references :stations,             foreign_key: true

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
# repositories
# seasons
# serials
# stations
