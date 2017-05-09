class AddIndicesToCrCompanies < ActiveRecord::Migration[4.2]
  def change
    add_index :cr_companies, :company_id
    add_index :cr_companies, :company_role_id
    add_index :cr_companies, :compilation_release_id
  end
end
