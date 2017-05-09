class IndexStationsOnLowerDisambiguationAndName < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_stations_on_lower_disambiguation_and_name
            ON stations (LOWER(disambiguation), LOWER(name));
        DDL
      end
      idx.down do
        remove_index(:stations,
                     name: :index_stations_on_lower_disambiguation_and_name)
      end
    end
  end
end
