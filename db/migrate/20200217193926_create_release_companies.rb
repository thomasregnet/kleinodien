class CreateReleaseCompanies < ActiveRecord::Migration[6.0]
  def change
    create_table :release_companies do |t|
      t.references :company, null: false, foreign_key: true
      t.references :company_role, foreign_key: true
      t.references :release, null: false, foreign_key: true

      t.timestamps
    end
  end
end
