class AddDateToCompilationReleases < ActiveRecord::Migration[4.2]
  def change
    add_column :compilation_releases, :date, :date
    add_column :compilation_releases, :date_mask, :integer
  end
end
