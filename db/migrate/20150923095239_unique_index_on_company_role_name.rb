class UniqueIndexOnCompanyRoleName < ActiveRecord::Migration[4.2]
  def change
    add_index :company_roles, :name, unique: true
  end
end
