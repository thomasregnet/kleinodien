class Track < ActiveRecord::Base
  composed_of(
    :duration,
    class_name: Duration.to_s,
    mapping: [ %w(milliseconds accuracy), %w(milliseconds accuracy) ]
  )
  default_scope { order('no ASC') }
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
  has_many(
    #:format_attributes,
    :details,
    class_name: TrackDetail,
    foreign_key: :track_id
  )
  validates :release, presence: true
end
