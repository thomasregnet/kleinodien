class RenameCommentsCommentsPieceReleaseIdToPieceId < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :piece_release_id, :piece_id
  end
end
