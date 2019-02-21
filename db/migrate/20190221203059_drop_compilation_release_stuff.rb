class DropCompilationReleaseStuff < ActiveRecord::Migration[5.2]
  def change
    drop_table :compilation_releases_countries
    drop_table :compilation_releases_tags
  end
end
