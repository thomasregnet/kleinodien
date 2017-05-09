class DropTrackCompilationSectionId < ActiveRecord::Migration[4.2]
  def change
    remove_column :tracks, :compilation_section_id
  end
end
