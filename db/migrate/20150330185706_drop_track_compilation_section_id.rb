class DropTrackCompilationSectionId < ActiveRecord::Migration
  def change
    remove_column :tracks, :compilation_section_id
  end
end
