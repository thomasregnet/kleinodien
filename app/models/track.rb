class Track < ActiveRecord::Base
  belongs_to :format
  belongs_to(
    :release,
    class_name: PieceRelease,
    foreign_key: :piece_release_id)
  belongs_to(
    :compilation,
    class_name: CompilationRelease,
    foreign_key: :compilation_release_id)
  validates :release, presence: true
end
