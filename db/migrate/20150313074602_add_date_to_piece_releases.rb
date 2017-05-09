class AddDateToPieceReleases < ActiveRecord::Migration[4.2]
  def change
    add_column :piece_releases, :date, :date
    add_column :piece_releases, :date_mask, :integer
  end
end
