class DropIndexCrFormatsOnCompilationReleaseIdAndFormatKind < ActiveRecord::Migration
  def change
    remove_index(
      :cr_formats,
      name: :index_cr_formats_on_compilation_release_id_and_format_kind_id
    )
  end
end
