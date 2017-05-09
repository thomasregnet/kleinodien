class RenameSectionFormatsColumnExplanationToNote < ActiveRecord::Migration[4.2]
  def change
    rename_column(:section_formats, :explanation, :note)
  end
end
