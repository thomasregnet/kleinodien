class AddMillisecondsAndAccuracyToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :milliseconds, :integer
    add_column :tracks, :accuracy, :string
  end
end
