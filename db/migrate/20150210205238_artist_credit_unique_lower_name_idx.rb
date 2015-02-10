class ArtistCreditUniqueLowerNameIdx < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX artist_credits_lower_name_idx
            ON artist_credits (LOWER(name))
        DDL
      end
      idx.down do
        remove_index(:artist_credits, name: :artist_credits_lower_name_idx)
      end
    end
  end
end
