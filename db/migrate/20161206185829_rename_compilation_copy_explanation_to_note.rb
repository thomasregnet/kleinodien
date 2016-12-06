class RenameCompilationCopyExplanationToNote < ActiveRecord::Migration[5.0]
  def change
    rename_column :compilation_copies, :explanation, :note
  end
end
