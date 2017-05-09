class CompilationSectionsSideNotNull < ActiveRecord::Migration[4.2]
  def change
    change_column(
      :compilation_sections, :side, :string, null: false, default: 'A')
  end
end
