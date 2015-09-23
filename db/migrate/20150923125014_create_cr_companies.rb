class CreateCrCompanies < ActiveRecord::Migration
  def change
    create_table :cr_companies do |t|
      t.integer :company_id, null: false
      t.integer :company_role_id, null: false
      t.string :catalog_no

      t.timestamps null: false
    end

    add_foreign_key :cr_companies, :companies
    add_foreign_key :cr_companies, :company_roles
  end
end
