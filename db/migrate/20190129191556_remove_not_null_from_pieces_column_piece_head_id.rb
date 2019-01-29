class RemoveNotNullFromPiecesColumnPieceHeadId < ActiveRecord::Migration[5.2]
  def change
    execute <<-DDL.gsub /^\s+/, ''
      ALTER TABLE pieces ALTER COLUMN piece_head_id DROP NOT NULL;
    DDL
  end
end
