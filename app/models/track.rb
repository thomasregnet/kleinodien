class Track < ActiveRecord::Base
  belongs_to :format
  belongs_to :piece_release
  validates :format, presence: true
end
