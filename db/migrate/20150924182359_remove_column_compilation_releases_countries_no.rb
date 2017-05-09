class RemoveColumnCompilationReleasesCountriesNo < ActiveRecord::Migration[4.2]
  def change
    remove_column :compilation_releases_countries, :no, :integer
  end
end
