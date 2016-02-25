class AddForeignKeysToCompilationReleasesCountries < ActiveRecord::Migration
  def change
    add_foreign_key :compilation_releases_countries, :compilation_releases
    add_foreign_key :compilation_releases_countries, :countries
  end
end
