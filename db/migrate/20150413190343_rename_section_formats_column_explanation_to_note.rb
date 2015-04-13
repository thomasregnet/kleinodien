class RenameSectionFormatsColumnExplanationToNote < ActiveRecord::Migration
  def change
    rename_column(:section_formats, :explanation, :note)
  end
end
