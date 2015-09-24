class RemoveColumnCompilationReleasesCountriesNo < ActiveRecord::Migration
  def change
    remove_column :compilation_releases_countries, :no, :integer
  end
end
