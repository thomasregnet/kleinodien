class IndexStationsOnLowerName < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_stations_on_lower_name
            ON stations (LOWER(name))
              WHERE disambiguation IS NULL;
        DDL
      end
      idx.down do
        remove_index :stations, name: :index_stations_on_lower_name
      end
    end
  end
end
