class IndexPieceHeadsOnLowerTitleRespectArtistCredit < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        remove_index :piece_heads, name: :index_piece_heads_on_lower_title

        execute <<-DDL
          CREATE UNIQUE INDEX index_piece_heads_on_lower_title
            ON piece_heads (artist_credit_id, type, LOWER(title))
              WHERE disambiguation IS NULL AND reference_id IS NULL;
        DDL
      end
      idx.down do
        remove_index :piece_heads, name: :index_piece_heads_on_lower_title

        execute <<-DDL
          CREATE UNIQUE INDEX index_piece_heads_on_lower_title
            ON piece_heads (type, LOWER(title))
              WHERE disambiguation IS NULL;
        DDL
      end
    end
  end
end
