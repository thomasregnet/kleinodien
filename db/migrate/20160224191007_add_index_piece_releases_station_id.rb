class AddIndexPieceReleasesStationId < ActiveRecord::Migration
  def change
    add_index :piece_releases, :station_id
  end
end
