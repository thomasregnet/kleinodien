class AddMillisecondsAndAccuracyToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :milliseconds, :integer
    add_column :tracks, :accuracy, :string
  end
end
