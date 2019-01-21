# Season of a serial, has many episodes
class Season < ActiveRecord::Base
  include CodeFindable

  belongs_to :serial, inverse_of: :seasons
  has_and_belongs_to_many :tags
  has_many :comments
  has_many :descriptions
  has_many :episodes, class_name: 'EpisodeHead', inverse_of: :season
  has_many :ratings

  validates :position, presence: true
end
