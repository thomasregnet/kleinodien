# A PieceRelease that maybe exists on a CompilationRelease
class CompilationTrack < ActiveRecord::Base
  default_scope { order('position ASC') }

  composed_of :duration,
              class_name: 'Duration',
              mapping: [%w(milliseconds milliseconds), %w(accuracy accuracy)]

  belongs_to :compilation_release,
             class_name:  CompilationRelease,
             foreign_key: :compilation_release_id
  belongs_to :format,
             class_name:  TrFormatKind,
             foreign_key: :tr_format_kind_id
  belongs_to :piece_release,
             class_name:  PieceRelease,
             foreign_key: :piece_release_id

  # TODO: new_format must be deleted
  belongs_to :new_format,
             class_name: CtFormat,
             foreign_key: :format_name,
             primary_key: :name

  has_many :details,
           class_name:  CompilationTrackDetail,
           foreign_key: :track_id
  has_many :repository_positions,
           inverse_of: :compilation_track,
           primary_key: [:id, :compilation_release_id],
           foreign_key: [:compilation_track_id, :compilation_release_id]

  validates :compilation_release, presence: true
  validates :piece_release,       presence: true
end
