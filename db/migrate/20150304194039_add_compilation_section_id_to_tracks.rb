class AddCompilationSectionIdToTracks < ActiveRecord::Migration[4.2]
  def change
    add_column :tracks, :compilation_section_id, :integer
  end
end
