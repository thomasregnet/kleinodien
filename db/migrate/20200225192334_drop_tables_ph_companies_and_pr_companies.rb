class DropTablesPhCompaniesAndPrCompanies < ActiveRecord::Migration[6.0]
  def change
    drop_table :ph_companies
    drop_table :pr_companies
  end
end
