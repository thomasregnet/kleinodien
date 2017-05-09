class ArtistsUniqueReferenceIdIndex < ActiveRecord::Migration[4.2]
  def change
      reversible do |idx|
      idx.up do
        execute <<-DDL.gsub /^\s+/, ''
          CREATE UNIQUE INDEX artists_reference_id
            ON artists (reference_id)
              WHERE reference_id IS NOT NULL;
        DDL
      end
      idx.down do
        remove_index(
          :artists,
          name: :artists_reference_id
        )
      end
    end  
  end
end
