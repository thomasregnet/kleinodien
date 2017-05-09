class RemoveTypeFromSeasons < ActiveRecord::Migration[4.2]
  def change
    remove_column :seasons, :type, :string
  end
end
