class AddForeignKeysToTrackDeteils < ActiveRecord::Migration[4.2]
  def change
    add_foreign_key :track_details, :tracks
  end
end
