class AddTrFromatKindIdToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :tr_format_kind_id, :integer
  end
end
