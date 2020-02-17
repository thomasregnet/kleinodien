class CreateReleaseCatalogNumbers < ActiveRecord::Migration[6.0]
  def change
    create_table :release_catalog_numbers do |t|
      t.text :code
      t.references :release_company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
