class IndexCompilationSectionMediumNo < ActiveRecord::Migration
  def change
    add_index(
      :compilation_sections,
      [:compilation_medium_id, :no],
      unique: true,
      where: 'side IS NULL')
  end
end
