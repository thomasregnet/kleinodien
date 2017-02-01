class AddIdentifierIdToArtists < ActiveRecord::Migration[5.0]
  def change
    add_reference :artists,
                  :artist_identifier,
                  foreign_key: true,
                  index: false

    add_index :artists, :artist_identifier_id, unique: true
  end
end
