class AddCollumnsToCompanies < ActiveRecord::Migration[6.0]
  def change
    add_column :companies, :sort_name, :text
    add_reference :companies, :area, foreign_key: true
    add_column :companies, :brainz_code, :uuid
    add_column :companies, :discogs_code, :integer
    add_column :companies, :label_code, :integer
    add_column :companies, :tmdb_code, :integer
    add_column :companies, :wikidata_code, :integer
  end
end
