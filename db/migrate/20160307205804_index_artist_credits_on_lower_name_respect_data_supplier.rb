class IndexArtistCreditsOnLowerNameRespectDataSupplier < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        drop_index
        execute <<-DDL
          CREATE UNIQUE INDEX "index_artist_credits_on_lower_name"
            ON "artist_credits" (LOWER(name))
              WHERE "data_supplier_id" IS NULL;
        DDL
      end
      idx.down do
        drop_index
        execute <<-DDL
          CREATE UNIQUE INDEX "index_artist_credits_on_lower_name"
            ON "artist_credits" (LOWER(name))
        DDL
      end
    end
  end

  def drop_index
    remove_index :artist_credits,
                 name: :index_artist_credits_on_lower_name
  end
end
