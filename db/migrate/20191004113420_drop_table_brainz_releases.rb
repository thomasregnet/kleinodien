class DropTableBrainzReleases < ActiveRecord::Migration[6.0]
  def change
    drop_table :brainz_releases
  end
end
