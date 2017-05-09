class RemoveDisambiguationIndicesOnPieceHead < ActiveRecord::Migration[4.2]
  def change
    remove_index(
      :piece_heads,
      name: :index_piece_heads_on_lower_title
    )
    remove_index(
      :piece_heads,
      name: :index_piece_heads_on_lower_title_disambiguation
    )
  end
end
