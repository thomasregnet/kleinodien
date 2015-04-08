class Track < ActiveRecord::Base
  belongs_to(
    :release,
    class_name: PieceRelease,
    foreign_key: :piece_release_id
  )
  belongs_to(
    :compilation,
    class_name: CompilationRelease,
    foreign_key: :compilation_release_id
  )
  belongs_to(
    :format,
    class_name: TrFormatKind,
    foreign_key: :tr_format_kind_id
  )
  validates :release, presence: true
end
