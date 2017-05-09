class RemoveDisambiguationIndicesOnCompilationHeads < ActiveRecord::Migration[4.2]
  def change
    remove_index(
      :compilation_heads,
      name: :index_compilation_heads_on_lower_title
    )
    remove_index(
      :compilation_heads,
      name: :index_compilation_heads_on_lower_title_disambiguation
    )
  end
end
