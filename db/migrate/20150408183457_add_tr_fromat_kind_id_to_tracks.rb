class AddTrFromatKindIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :tr_format_kind_id, :integer
  end
end
