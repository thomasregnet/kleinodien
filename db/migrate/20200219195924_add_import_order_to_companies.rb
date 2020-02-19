class AddImportOrderToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_reference :companies, :import_order, foreign_key: true
  end
end
