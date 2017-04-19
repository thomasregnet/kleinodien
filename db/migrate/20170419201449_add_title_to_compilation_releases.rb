class AddTitleToCompilationReleases < ActiveRecord::Migration[5.0]
  def change
    add_column :compilation_releases, :title, :citext, null: false
  end
end
