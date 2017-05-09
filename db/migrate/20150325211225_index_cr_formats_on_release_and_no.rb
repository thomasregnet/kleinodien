class IndexCrFormatsOnReleaseAndNo < ActiveRecord::Migration[4.2]
  def change
    add_index(
      :cr_formats,
      [:compilation_release_id, :format_kind_id],
      unique: true
    )
  end
end
