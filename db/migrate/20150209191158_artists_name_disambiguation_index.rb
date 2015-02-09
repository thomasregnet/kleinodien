class ArtistsNameDisambiguationIndex < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX artists_name_disambiguation_index
            ON artists
              ((lower(name)), lower(disambiguation));
        DDL
      end
      idx.down do
        remove_index(:artists, name: :artists_name_disambiguation_index)
      end          
    end
  end
end
