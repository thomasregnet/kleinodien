class CompanyRolesNameCitext < ActiveRecord::Migration[6.0]
  def change
    remove_column :company_roles, :name

    add_column :company_roles, :name, :citext, null: false
    add_index(
      :company_roles,
      'lower(name)',
      name:   'index_company_roles_on_lower_name',
      unique: true
    )
  end
end
