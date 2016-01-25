class AddSideToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :side, :string
  end
end
