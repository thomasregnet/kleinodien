class AddBrainzCodeToArtists < ActiveRecord::Migration[5.1]
  def change
    add_column :artists, :brainz_code, :uuid, unique: true
  end
end
