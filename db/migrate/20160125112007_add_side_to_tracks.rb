class AddSideToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :side, :string
  end
end
