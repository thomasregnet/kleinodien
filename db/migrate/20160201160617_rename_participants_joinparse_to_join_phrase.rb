class RenameParticipantsJoinparseToJoinPhrase < ActiveRecord::Migration
  def change
    rename_column :participants, :joinparse, :join_phrase
  end
end
