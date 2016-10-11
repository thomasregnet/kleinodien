# A PieceRelease that maybe exists on a CompilationRelease
class CompilationTrack < ActiveRecord::Base
  default_scope { order('no ASC') }

  composed_of :duration,
              class_name: 'Duration',
              mapping: [%w(milliseconds milliseconds), %w(accuracy accuracy)]

  # belongs_to :release,
  belongs_to :piece,
             class_name:  PieceRelease,
             foreign_key: :piece_release_id
  belongs_to :compilation,
             class_name:  CompilationRelease,
             foreign_key: :compilation_release_id
  belongs_to :format,
             class_name:  TrFormatKind,
             foreign_key: :tr_format_kind_id
  has_many :repository_positions,
           primary_key: [:id, :compilation_release_id],
           foreign_key: [:compilation_track_id, :compilation_release_id]
  has_many :details,
           class_name:  CompilationTrackDetail,
           foreign_key: :track_id

  validates :compilation, presence: true
  # validates :release,     presence: true
  validates :piece,     presence: true
end
