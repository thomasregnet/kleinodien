class PieceTrack < ApplicationRecord
  belongs_to :release, class_name: PieceRelease, foreign_key: :piece_release_id
  belongs_to :tr_format_kinds

  composed_of :duration,
              class_name: 'Duration',
              mapping: [%w(milliseconds milliseconds), %w(accuracy accuracy)]

  validates :release, presence: true
end
