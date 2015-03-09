class AlbumHead < CompilationHead
  belongs_to :artsit_credit
  has_many(
    :releases,
    class_name: AlbumRelease,
    foreign_key: :compilation_head_id)
end
