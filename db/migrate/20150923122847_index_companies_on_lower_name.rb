class IndexCompaniesOnLowerName < ActiveRecord::Migration
  def change
    reversible do |idx|
      idx.up do
        execute <<-DDL
          CREATE UNIQUE INDEX index_companies_on_lower_name
            ON companies (LOWER(name));
        DDL
      end
      idx.down do
        remove_index :companies, name: :index_companies_on_lower_name
      end
    end
  end
end
