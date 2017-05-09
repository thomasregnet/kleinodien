class RenameParticipantsJoinparseToJoinPhrase < ActiveRecord::Migration[4.2]
  def change
    rename_column :participants, :joinparse, :join_phrase
  end
end
