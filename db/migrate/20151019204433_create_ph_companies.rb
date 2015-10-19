class CreatePhCompanies < ActiveRecord::Migration
  def change
    create_table :ph_companies do |t|
      t.references :piece_head, index: true, foreign_key: true, null: false
      t.references :company, index: true, foreign_key: true, null: false
      t.references :company_role, index: true, foreign_key: true, null: false
      t.string :catalog_no

      t.timestamps null: false
    end
  end
end
