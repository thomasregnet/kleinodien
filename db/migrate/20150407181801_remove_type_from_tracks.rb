class RemoveTypeFromTracks < ActiveRecord::Migration
  def change
    remove_column :tracks, :type, :string
  end
end
