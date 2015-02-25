class Season < ActiveRecord::Base
  belongs_to :serial, inverse_of: :seasons
  has_many :episodes, class_name: EpisodeHead, inverse_of: :season
  validates :serial, presence: true
  validates :no,     presence: true
end
