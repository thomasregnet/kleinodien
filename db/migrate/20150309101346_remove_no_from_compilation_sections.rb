class RemoveNoFromCompilationSections < ActiveRecord::Migration[4.2]
  def change
    remove_column(:compilation_sections, :no, :integer)
  end
end
