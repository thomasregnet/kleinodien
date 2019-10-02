class AddIndexPiecesPieceHeadId < ActiveRecord::Migration[6.0]
  def change
    add_index :pieces, :piece_head_id, name: :index_on_pieces_piece_head_id
  end
end
