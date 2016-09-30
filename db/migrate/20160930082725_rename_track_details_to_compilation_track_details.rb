class RenameTrackDetailsToCompilationTrackDetails < ActiveRecord::Migration[5.0]
  def change
    reversible do |rename|
      rename.up do
        rename_table :track_details, :compilation_track_details
      end
      rename.down do
        rename_table :compilation_track_details, :track_details
      end
    end
  end
end
