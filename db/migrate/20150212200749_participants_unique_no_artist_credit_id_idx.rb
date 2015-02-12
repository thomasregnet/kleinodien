class ParticipantsUniqueNoArtistCreditIdIdx < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX participants_no_artist_credit_id_idx
            ON participants (no, artist_credit_id)
         DDL
      end
      idx.down do
        remove_index(:participants, :participants_no_artist_credit_id_idx)
      end
    end
  end
end
