class IndexPieceHeadOnTypeAndLowerTitleAndDisambiguation < ActiveRecord::Migration
  def change
     reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_piece_heads_on_lower_title_disambiguation
            ON piece_heads (type, LOWER(title), LOWER(disambiguation))
        DDL
      end
      idx.down do
        remove_index(
          :piece_heads, name: :index_piece_heads_on_lower_title_disambiguation
        )
      end
    end
  end
end
