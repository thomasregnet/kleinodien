class UniqueIndexOnCompanyRoleName < ActiveRecord::Migration
  def change
    add_index :company_roles, :name, unique: true
  end
end
