class MinimizeCompilationReleasesCountries < ActiveRecord::Migration[4.2]
  def change
    remove_column :compilation_releases_countries, :id, :integer
    remove_column :compilation_releases_countries, :created_at, :datetime
    remove_column :compilation_releases_countries, :updated_at, :datetime
  end
end
