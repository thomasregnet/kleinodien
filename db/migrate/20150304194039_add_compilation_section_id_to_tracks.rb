class AddCompilationSectionIdToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :compilation_section_id, :integer
  end
end
