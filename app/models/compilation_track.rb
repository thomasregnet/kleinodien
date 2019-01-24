# A Piece that maybe exists on a CompilationRelease
class CompilationTrack < ActiveRecord::Base
  default_scope { order('position ASC') }

  composed_of :duration,
              class_name: 'Duration',
              mapping: [%w[milliseconds milliseconds], %w[accuracy accuracy]]

  belongs_to :compilation_release,
             class_name:  'CompilationRelease',
             foreign_key: :compilation_release_id
  belongs_to :format, required: false
  belongs_to :piece
             # class_name:  'Piece',
             # foreign_key: :piece_id

  has_many :format_details,
           class_name: 'CtFormatDetail',
           foreign_key: :compilation_track_id
  has_many :repository_positions
end
