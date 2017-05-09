class IndexCrFormatsOnCompilationReleaseIdAndNo < ActiveRecord::Migration[4.2]
  def change
    add_index(
      :cr_formats,
      [:compilation_release_id, :no],
      unique: true
    )
  end
end
