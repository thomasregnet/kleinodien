class CreateChCompanies < ActiveRecord::Migration[4.2]
  def change
    create_table :ch_companies do |t|
      t.references :compilation_head, index: true, foreign_key: true, null: false
      t.references :company, index: true, foreign_key: true, null: false
      t.references :company_role, index: true, foreign_key: true, null: false
      t.string :catalog_no

      t.timestamps null: false
    end
  end
end
