class IndexCountriesOnLowerName < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_countries_on_lower_name
            ON countries (LOWER(name));
        DDL
      end
      idx.down do
        remove_index :countries, name: :index_countries_on_lower_name
      end
    end
  end
end
