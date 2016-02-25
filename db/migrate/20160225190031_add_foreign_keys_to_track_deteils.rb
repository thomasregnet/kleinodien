class AddForeignKeysToTrackDeteils < ActiveRecord::Migration
  def change
    add_foreign_key :track_details, :tracks
  end
end
