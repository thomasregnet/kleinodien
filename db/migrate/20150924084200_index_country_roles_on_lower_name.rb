class IndexCountryRolesOnLowerName < ActiveRecord::Migration[4.2]
  def change
    reversible do |idx|
      idx.up do
        remove_index :company_roles, name: :index_company_roles_on_name

        execute <<-DDL
          CREATE UNIQUE INDEX index_company_roles_on_lower_name
            ON company_roles (LOWER(name));
        DDL
      end
      idx.down do
        remove_index :company_roles, name: :index_company_roles_on_lower_name
        add_index :company_roles, :name, unique: true
      end
    end
  end
end
