class Track < ActiveRecord::Base
  belongs_to :format
  belongs_to :release, class_name: PieceRelease, foreign_key: :piece_release_id
  validates :format, presence: true
  validates :release, presence: true
end
