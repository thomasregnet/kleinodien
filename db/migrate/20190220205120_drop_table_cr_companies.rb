class DropTableCrCompanies < ActiveRecord::Migration[5.2]
  def change
    drop_table :cr_companies
  end
end
