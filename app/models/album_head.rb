class AlbumHead < CompilationHead
  has_many(
    :releases,
    class_name: AlbumRelease,
    foreign_key: :compilation_head_id)
end
