class IndexPieceHeadsOnLowerTitleDisambiguationRespectArtistCredit < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        remove_index :piece_heads,
                     name: :index_piece_heads_on_lower_title_disambiguation

        execute <<-DDL
          CREATE UNIQUE INDEX index_piece_heads_on_lower_title_disambiguation
            ON piece_heads
              (artist_credit_id, type, LOWER(title), LOWER(disambiguation))
        DDL
      end
      idx.down do
        remove_index :piece_heads,
                     name: :index_piece_heads_on_lower_title_disambiguation

         execute <<-DDL
          CREATE UNIQUE INDEX index_piece_heads_on_lower_title_disambiguation
            ON piece_heads (type, LOWER(title), LOWER(disambiguation))
        DDL
      end
    end
  end
end
