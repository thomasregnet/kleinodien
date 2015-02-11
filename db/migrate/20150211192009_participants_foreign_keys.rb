class ParticipantsForeignKeys < ActiveRecord::Migration
  def change
    add_foreign_key :participants, :artists, name: :participants_fk_artists
    add_foreign_key :participants, :artist_credits,
                    name: :participants_fk_artist_credits
  end
end
