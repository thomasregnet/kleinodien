class AddDateToCompilationReleases < ActiveRecord::Migration
  def change
    add_column :compilation_releases, :date, :date
    add_column :compilation_releases, :date_mask, :integer
  end
end
