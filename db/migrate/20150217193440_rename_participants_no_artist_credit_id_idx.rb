class RenameParticipantsNoArtistCreditIdIdx < ActiveRecord::Migration
  def change
    old = 'participants_no_artist_credit_id_idx'
    new = 'index_participants_on_artist_credit_id_and_no'
    reversible do |rename|
      rename.up do
        execute "ALTER INDEX #{old} RENAME TO #{new}"
      end
      rename.down do
        execute "ALTER INDEX #{new} RENAME TO #{old}"
      end
    end
  end
end
