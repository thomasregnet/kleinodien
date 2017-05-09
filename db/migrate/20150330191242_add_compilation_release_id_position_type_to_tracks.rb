class AddCompilationReleaseIdPositionTypeToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :compilation_release_id, :integer
    add_column :tracks, :position, :string
    add_column :tracks, :type, :string
  end
end
