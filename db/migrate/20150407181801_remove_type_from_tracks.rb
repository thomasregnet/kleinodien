class RemoveTypeFromTracks < ActiveRecord::Migration[4.2]
  def change
    remove_column :tracks, :type, :string
  end
end
