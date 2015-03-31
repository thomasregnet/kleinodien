class AddHeadingToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :heading, :string
  end
end
