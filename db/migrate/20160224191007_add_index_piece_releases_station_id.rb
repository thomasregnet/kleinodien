class AddIndexPieceReleasesStationId < ActiveRecord::Migration[4.2]
  def change
    add_index :piece_releases, :station_id
  end
end
