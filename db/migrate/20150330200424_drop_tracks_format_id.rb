class DropTracksFormatId < ActiveRecord::Migration
  def change
    remove_column :tracks, :format_id
  end
end
