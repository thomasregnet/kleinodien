class RemoveNoFromCompilationSections < ActiveRecord::Migration
  def change
    remove_column(:compilation_sections, :no, :integer)
  end
end
