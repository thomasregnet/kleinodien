class DropTracksFormatId < ActiveRecord::Migration[4.2]
  def change
    remove_column :tracks, :format_id
  end
end
