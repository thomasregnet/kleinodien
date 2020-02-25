class UniqueIndexReleaseCatalogNumbersOnCodeAndReleaseCompany < ActiveRecord::Migration[6.0]
  def change
    add_index(
      :release_catalog_numbers,
      [:code, :release_company_id],
      unique: true
    )
  end
end
