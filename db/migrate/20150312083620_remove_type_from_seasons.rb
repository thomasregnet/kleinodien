class RemoveTypeFromSeasons < ActiveRecord::Migration
  def change
    remove_column :seasons, :type, :string
  end
end
