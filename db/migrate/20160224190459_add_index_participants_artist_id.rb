class AddIndexParticipantsArtistId < ActiveRecord::Migration[4.2]
  def change
    add_index :participants, :artist_id
  end
end
