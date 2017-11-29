class AddBrainzCodeToArtists < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :brainz_code, :uuid

    add_index :artists,
              :brainz_code,
              unique: true,
              name: :index_on_artists_brainz_code
  end
end
