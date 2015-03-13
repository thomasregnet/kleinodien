class AddDateToPieceReleases < ActiveRecord::Migration
  def change
    add_column :piece_releases, :date, :date
    add_column :piece_releases, :date_mask, :integer
  end
end
