class IndexCompilationSectionMediumNoSide < ActiveRecord::Migration
  def change
    add_index(:compilation_sections,
              [:compilation_medium_id, :no, :side],
              unique: true,
              name: :index_compilation_sections_on_medium_no_side)
  end
end
