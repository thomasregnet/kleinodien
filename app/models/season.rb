# Season of a serial, has many episodes
class Season < ActiveRecord::Base
  belongs_to :serial, inverse_of: :seasons
  has_many :comments
  has_many :episodes, class_name: EpisodeHead, inverse_of: :season
  has_many :ratings
  validates :position, presence: true
  validates :serial,   presence: true
end
