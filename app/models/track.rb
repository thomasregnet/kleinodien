class Track < ActiveRecord::Base
  belongs_to :format
  belongs_to :piece_release
  validates :format, presence: true
  validates :piece_release, presence: true
end
