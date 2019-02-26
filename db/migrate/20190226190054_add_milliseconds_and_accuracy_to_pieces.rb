class AddMillisecondsAndAccuracyToPieces < ActiveRecord::Migration[5.2]
  def change
    add_column :pieces, :milliseconds, :integer
    add_column :pieces, :accuracy, :text
  end
end
