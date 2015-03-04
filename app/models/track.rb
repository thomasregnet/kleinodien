class Track < ActiveRecord::Base
  belongs_to :format
  belongs_to(
    :release,
    class_name: PieceRelease,
    foreign_key: :piece_release_id)
  belongs_to(
    :section,
    inverse_of: :tracks,
    class_name: CompilationSection,
    foreign_key: :compilation_section_id)
  validates :format, presence: true
  validates :release, presence: true
end
