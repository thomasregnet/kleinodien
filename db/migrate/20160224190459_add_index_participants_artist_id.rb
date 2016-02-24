class AddIndexParticipantsArtistId < ActiveRecord::Migration
  def change
    add_index :participants, :artist_id
  end
end
